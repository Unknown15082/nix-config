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
                ];
                hash = "sha256-MyCauokxAulv2LuR/MJIl1oCPGLzS9Ind5AjiKgCQPw=";
            };

            environmentFile = config.age.secrets.caddy_env.path;

            globalConfig = ''
                				acme_dns cloudflare {env.CF_API_TOKEN}
                			'';
        };
    };
}
