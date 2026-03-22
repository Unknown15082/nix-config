{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.stirling-pdf;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.stirling-pdf = {
        enable = lib.mkEnableOption "service: stirling-pdf";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7003;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        modules.services.caddyHosts."pdf" = {
            reverseProxyPort = serviceCfg.port;
            tailscaleOnly = true;
        };

        services.stirling-pdf = {
            enable = true;
            environment = {
                SERVER_PORT = serviceCfg.port;
            };
        };
    };
}
