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
        modules.services.caddyHosts."test" = {
            extraConfig = ''
                respond "Testing"
            '';

            proxyAuth = true;
        };
    };
}
