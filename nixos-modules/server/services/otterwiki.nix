{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.otterwiki;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.otterwiki = {
        enable = lib.mkEnableOption "service: otterwiki";
        dataPath = lib.mkOption {
            description = "The data path to be mounted";
            type = lib.types.str;
            default = "/etc/otterwiki/data";
        };
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7001;
        };
        environmentFiles = lib.mkOption {
            description = "Additional environment variables";
            type = lib.types.listOf lib.types.str;
            default = [ ];
        };
    };

    config = lib.mkIf serviceCfg.enable {
        modules.services.caddyHosts."wiki" = {
            reverseProxyPort = serviceCfg.port;
            tailscaleOnly = true;
        };

        environment.etc."otterwiki/.env".text = ''
                        SITE_NAME=Otterwiki
                        SITE_DESCRIPTION=Unknown's personal wiki

                        WRITE_ACCESS=APPROVED
                        ATTACHMENT_ACCESS=APPROVED

                        COMMIT_MESSAGE=OPTIONAL
                    '';

        systemd.tmpfiles.rules = [
            "d /etc/otterwiki/data 755 otterwiki otterwiki"
        ];

        virtualisation.oci-containers = with serviceCfg; {
            containers.otterwiki = {
                environmentFiles = serviceCfg.environmentFiles ++ [ "/etc/otterwiki/.env" ];

                image = "redimp/otterwiki:2-slim";
                ports = [ "127.0.0.1:${toString port}:8080" ];
                volumes = [
                    "${dataPath}:/app-data"
                ];
                user = "2001";
                pull = "newer";
            };
        };

        users.users.otterwiki = {
            isSystemUser = true;
            uid = 2001;
            group = "otterwiki";
        };
        users.groups.otterwiki = { };
    };
}
