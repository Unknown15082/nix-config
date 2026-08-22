{
    lib,
    config,
    pkgs,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
in
{
    config = lib.mkIf (cfg.enable && cfg.reverseProxy == "caddy") {
        age.secrets.caddy_env = {
            file = "${secrets}/caddy_env.age";
            mode = "400";
            owner = config.services.caddy.user;
            group = config.services.caddy.group;
        };

        services.caddy = {
            enable = true;
            package = pkgs.caddy.withPlugins {
                plugins = [
                    "github.com/caddy-dns/cloudflare@v0.2.1"
                    "github.com/greenpau/caddy-security@v1.1.31"
                    "github.com/WeidiDeng/caddy-cloudflare-ip@v0.0.0-20231130002422-f53b62aa13cb"
                ];
                hash = "sha256-93FZF2mrJPRWIcXeA2Ja6oWkg20uflCAE2R6cwCMPSk=";
            };

            environmentFile = config.age.secrets.caddy_env.path;

            globalConfig = ''
                                                acme_dns cloudflare {env.CF_API_TOKEN}

                                                servers {
                                                    trusted_proxies cloudflare
                                                }
                                            '';
        };
    };
}
