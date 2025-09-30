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

		reverseProxy = lib.mkOption {
			description = "Reverse proxy used";
			type = lib.types.enum [ "caddy" ];
		};
	};

	config = lib.mkIf cfg.enable {
		networking.firewall = {
			allowedTCPPorts = [ 80 443 ];
		};

		virtualisation.oci-containers.backend = "podman";
	};
}
