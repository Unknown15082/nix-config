{ lib, config, pkgs, ... }:
let
	cfg = config.modules.selfhost;
in {
	options.modules.selfhost = {
		enable = lib.mkEnableOption "selfhosting softwares";

		domainName = lib.mkOption {
			description = "The default domain name used";
			type = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		services.caddy = {
			enable = true;
			package = pkgs.caddy.withPlugins {
				plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" "github.com/greenpau/caddy-security@v1.0.14" ];
				hash = "sha256-9MIZ55SpD8kocAmTzkCMnguaQuW5yvkjF9LXnNlCa/Q=";
			};

			environmentFile = config.age.secrets.cloudflare_token.path;
			globalConfig = ''
				acme_dns cloudflare {$CF_API_TOKEN}
			'';
		};

		networking.firewall = {
			allowedTCPPorts = [ 80 443 ];
		};

		virtualisation.oci-containers.backend = "podman";
	};
}
