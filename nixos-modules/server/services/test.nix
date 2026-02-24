{ lib, config, ... }:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.test;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.test = {
        enable = lib.mkEnableOption "service: test";
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."test.${domainName}".extraConfig = ''
                                				@tailnet remote_ip 100.64.0.0/10

                                				handle @tailnet {
                                					respond "Hello from tailnet!"
                                				}

                                				handle {
                									import tinyauth
                                					respond "Testing"
                                				}'';
        };
    };
}
