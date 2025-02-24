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
					plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e" ];
					hash = "sha256-JVkUkDKdat4aALJHQCq1zorJivVCdyBT+7UhqTvaFLw=";
				}
			else pkgs.caddy;

			# TODO: Move this to agenix
			environmentFile = "/etc/secrets/caddy.env";
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
