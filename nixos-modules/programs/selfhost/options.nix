{ lib, config, pkgs, ... }:
let
	cfg = config.modules.selfhost;
in {
	options.modules.selfhost = {
		enable = lib.mkEnableOption "selfhosting softwares";
		enableCloudflare = lib.mkEnableOption "cloudflare plugin";

		domainName = lib.mkOption {
			description = "The default domain name used";
			type = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		services.caddy = {
			enable = true;
			package = if cfg.enableCloudflare then
				pkgs.caddy.withPlugins {
					plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
					hash = "sha256-saKJatiBZ4775IV2C5JLOmZ4BwHKFtRZan94aS5pO90=";
				}
			else pkgs.caddy;

			environmentFile = config.age.secrets.cloudflare_token.path;
			globalConfig = if cfg.enableCloudflare then ''
				acme_dns cloudflare {$CF_API_TOKEN}
			'' else "";
		};

		networking.firewall = {
			allowedTCPPorts = [ 80 443 ];
		};

		virtualisation.oci-containers.backend = "podman";
	};
}
