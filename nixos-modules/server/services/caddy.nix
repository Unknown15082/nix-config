{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.services;
in
{
    config = lib.mkIf (cfg.enable && cfg.reverseProxy == "caddy") {
        services.tailscaleAuth.enable = true;

        services.caddy = {
            enable = true;
            package = pkgs.caddy.withPlugins {
                plugins = [
                    "github.com/caddy-dns/cloudflare@v0.2.1"
                    "github.com/greenpau/caddy-security@v1.1.31"
                ];
                hash = "sha256-AxrLKxrnJEDUlK5m4nAlUz+RfLH0Io8fZS2nyTyF22w=";
            };

            environmentFile = config.age.secrets.caddy_env.path;

            globalConfig = ''
                				acme_dns cloudflare {env.CF_API_TOKEN}
                			'';

            extraConfig =
                let
                    socketPath = config.services.tailscaleAuth.socketPath;
                in
                ''
                    				(tailscale) {
                    					forward_auth unix/${socketPath} {
                    						uri /auth
                    						header_up Remote-Addr {remote_host}
                    						header_up Remote-Port {remote_port}
                    						header_up Original-URI {uri}

                    						copy_headers {
                    							Tailscale-User>X-Webauth-User
                    							Tailscale-Name>X-Webauth-Name
                    							Tailscale-Login>X-Webauth-Login
                    							Tailscale-Tailnet>X-Webauth-Tailnet
                    							Tailscale-Profile-Picture>X-Webauth-Profile-Picture
                    						}
                    					}
                    				}
                    			'';
        };

        systemd.services.caddy = {
            serviceConfig = {
                SupplementaryGroups = [ config.services.tailscaleAuth.group ];
                ReadWritePaths = [ config.services.tailscaleAuth.socketPath ];
            };
        };
    };
}
