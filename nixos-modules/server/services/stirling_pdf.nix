{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.services.stirling-pdf;
    domainName = cfg.domainName;
in
{
    options.modules.services.services.stirling-pdf = {
        enable = lib.mkEnableOption "service: stirling-pdf";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."spdf.${domainName}".extraConfig = ''
                				import tailscale
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        services.stirling-pdf = {
            enable = true;
            environment = {
                SERVER_PORT = serviceCfg.port;
            };
        };
    };
}
