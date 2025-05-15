{ lib, config, username, ... }:
let
	cfg = config.modules.selfhost;
	serviceCfg = cfg.services.headscale;
	domainName = cfg.domainName;
in {
	options.modules.selfhost.services.headscale = {
		enable = lib.mkEnableOption "service: headscale";
		port = lib.mkOption {
			description = "The exposed port";
			type = lib.types.int;
		};
	};

	config = lib.mkIf serviceCfg.enable {
		services.caddy = {
			virtualHosts."hs.${domainName}".extraConfig = ''
				reverse_proxy :${toString serviceCfg.port}
			'';
		};

		services.tailscale = {
			enable = true;
			useRoutingFeatures = "server";
		};

		services.headscale = {
			enable = true;
			address = "0.0.0.0";
			port = serviceCfg.port;

			settings = {
				server_url = "https://hs.${domainName}";
				
				dns = {
					base_domain = "net.ts";
				};

				noise.private_key_path = "/var/lib/headscale/noise_private.key";
			};
		};
	};
}
