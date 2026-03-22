{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.silverbullet;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.silverbullet = {
        enable = lib.mkEnableOption "service: Silverbullet";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7006;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        modules.services.caddyHosts."notes" = {
            reverseProxyPort = serviceCfg.port;
            tailscaleOnly = true;
        };

        services.silverbullet = {
            enable = true;
            listenAddress = "0.0.0.0";
            listenPort = serviceCfg.port;
        };
    };
}
