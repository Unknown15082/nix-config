{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.services.silverbullet;
    domainName = cfg.domainName;
in
{
    options.modules.services.services.silverbullet = {
        enable = lib.mkEnableOption "service: Silverbullet";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."notes.${domainName}".extraConfig = ''
                				import tailscale
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        services.silverbullet = {
            enable = true;
            listenAddress = "0.0.0.0";
            listenPort = serviceCfg.port;
        };
    };
}
