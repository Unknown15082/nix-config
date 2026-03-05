{
    lib,
    config,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.shlink;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.shlink = {
        enable = lib.mkEnableOption "service: Shlink";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7010;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."url.${domainName}".extraConfig = ''
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        virtualisation.oci-containers = {
            containers.shlink = {
                environment = {
                    DEFAULT_DOMAIN = "url.${cfg.domainName}";
                    IS_HTTPS_ENABLED = true;
                };

                image = "shlinkio/shlink:stable";
                pull = "newer";

                ports = [ "${toString serviceCfg.port}:8080" ];
            };
        };
    };
}
