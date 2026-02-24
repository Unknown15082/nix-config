{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.index;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.index = {
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
