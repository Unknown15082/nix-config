{
    lib,
    config,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.tinyauth;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.tinyauth = {
        enable = lib.mkEnableOption "service: tinyauth";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7008;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."auth.${domainName}".extraConfig = ''
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        age.secrets.tinyauth = {
            file = "${secrets}/tinyauth.age";
            mode = "400";
            owner = "2002";
        };

        systemd.tmpfiles.rules = [
            "d /var/lib/tinyauth 755 tinyauth tinyauth"
        ];

        virtualisation.oci-containers = {
            containers.tinyauth = {
                environment =
                    let
                        providerURL = "https://pocketid.${domainName}";
                        appURL = "https://auth.${domainName}";
                    in
                    {
                        APP_URL = appURL;
                        OAUTH_AUTO_REDIRECT = "pocketid";

                        PROVIDERS_POCKETID_AUTH_URL = "${providerURL}/authorize";
                        PROVIDERS_POCKETID_TOKEN_URL = "${providerURL}/api/oidc/token";
                        PROVIDERS_POCKETID_USER_INFO_URL = "${providerURL}/api/oidc/userinfo";
                        PROVIDERS_POCKETID_REDIRECT_URL = "${appURL}/api/oauth/callback/pocketid";
                        PROVIDERS_POCKETID_SCOPES = "openid email profile groups";
                        PROVIDERS_POCKETID_NAME = "Pocket ID";
                    };

                environmentFiles = [ config.age.secrets.tinyauth.path ];

                image = "ghcr.io/steveiliop56/tinyauth:v4";
                hostname = "tinyauth";
                pull = "newer";

                user = "2002";

                ports = [ "${toString serviceCfg.port}:3000" ];
                volumes = [
                    "/var/lib/tinyauth:/data"
                ];
            };
        };

        users.users.tinyauth = {
            isSystemUser = true;
            uid = 2002;
            group = "tinyauth";
        };
        users.groups.tinyauth = { };
    };
}
