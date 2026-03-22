{ lib, config, ... }:
let
    cfg = config.modules.services;

    hostSubmodule =
        { name, lib, ... }:
        {
            options = {
                domain = lib.mkOption {
                    type = lib.types.str;
                    default = "${name}.${cfg.domainName}";
                    description = "Domain name for this host";
                };

                extraConfig = lib.mkOption {
                    type = lib.types.lines;
                    default = "";
                    description = "Extra config for this host";
                };

                reverseProxyPort = lib.mkOption {
                    type = lib.types.nullOr lib.types.int;
                    default = null;
                    description = "Reverse proxy port for this host";
                };

                tailscaleOnly = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                    description = "Whether this host can only be accessed through Tailscale";
                };

                proxyAuth = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                    description = "Whether to enable extra proxy authentication for this host";
                };
            };
        };
in
{
    options.modules.services.caddyHosts = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule hostSubmodule);
        default = { };
        description = "Attribute set of Caddy virtual hosts";
    };

    config = lib.mkIf (cfg.caddyHosts != { }) {
        services.caddy.virtualHosts = lib.mapAttrs' (
            _name: hostCfg:
            lib.nameValuePair "${hostCfg.domain}" {
                extraConfig =
                    let
                        mainBody = with hostCfg; ''
                            ${(if proxyAuth then "import tinyauth" else "")}
                            ${(if reverseProxyPort != null then "reverse_proxy :${toString reverseProxyPort}" else "")}
                            ${hostCfg.extraConfig}
                        '';
                    in
                    (
                        if hostCfg.tailscaleOnly then
                            ''
                                @tailnet remote_ip 100.64.0.0/10

                                handle @tailnet {
                                    ${mainBody}
                                }

                                handle {
                                    respond 404
                                }
                            ''
                        else
                            ''
                                ${mainBody}
                            ''
                    );
            }
        ) cfg.caddyHosts;
    };
}
