{
    lib,
    config,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.miniflux;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.miniflux = {
        enable = lib.mkEnableOption "service: Miniflux";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7012;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        age.secrets.miniflux = {
            file = "${secrets}/miniflux.age";
            mode = "400";
            owner = "miniflux";
        };

        modules.services.caddyHosts."rss" = {
            reverseProxyPort = serviceCfg.port;
            tailscaleOnly = true;
        };

        services.miniflux = {
            enable = true;

            # Sets "miniflux" in ensureUsers and ensureDatabases, as well as drop 'hstore' extension.
            createDatabaseLocally = true;

            # Contains ADMIN_USERNAME, ADMIN_PASSWORD, OAUTH2_CLIENT_ID and OAUTH2_CLIENT_SECRET
            adminCredentialsFile = config.age.secrets.miniflux.path;

            config =
                let
                    baseURL = "https://rss.${domainName}";
                in
                {
                    BASE_URL = baseURL;
                    LISTEN_ADDR = "localhost:${toString serviceCfg.port}";

                    OAUTH2_PROVIDER = "oidc";
                    OAUTH2_OIDC_PROVIDER_NAME = "Pocket ID";
                    OAUTH2_REDIRECT_URL = "${baseURL}/oauth2/oidc/callback";
                    OAUTH2_OIDC_DISCOVERY_ENDPOINT = "https://pocketid.${domainName}";

                    FETCH_YOUTUBE_WATCH_TIME = 1; # true
                    POLLING_FREQUENCY = 15;
                };
        };

        users.users.miniflux = {
            isSystemUser = true;
            uid = 2004;
            group = "miniflux";
        };
        users.groups.miniflux = { };
    };
}
