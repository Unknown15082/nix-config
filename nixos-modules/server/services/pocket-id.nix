{
    lib,
    config,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.pocket-id;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.pocket-id = {
        enable = lib.mkEnableOption "service: Pocket ID";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7007;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        modules.services.caddyHosts."pocketid" = {
            reverseProxyPort = serviceCfg.port;
        };

        age.secrets.pocket-id = {
            file = "${secrets}/pocket-id.age";
            mode = "400";
            owner = config.services.pocket-id.user;
            group = config.services.pocket-id.group;
        };

        services.pocket-id = {
            enable = true;
            environmentFile = config.age.secrets.pocket-id.path;

            settings = {
                APP_URL = "https://pocketid.${domainName}";
                TRUST_PROXY = true;
                PORT = serviceCfg.port;
            };
        };
    };
}
