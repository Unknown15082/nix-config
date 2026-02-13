{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.services.index;
    domainName = cfg.domainName;
in
{
    options.modules.services.services.index = {
        enable = lib.mkEnableOption "service: index";
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."${domainName}".extraConfig = ''
                				respond "Index page"
                			'';
        };
    };
}
