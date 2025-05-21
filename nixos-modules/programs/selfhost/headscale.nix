{ lib, config, username, ... }:
let
	cfg = config.modules.selfhost;
	serviceCfg = cfg.services.headscale;
	domainName = cfg.domainName;

	webuiReverseProxy = lib.optionalString serviceCfg.webui.enable "reverse_proxy /web* :${toString serviceCfg.webui.port}";
in {
	options.modules.selfhost.services.headscale = {
		enable = lib.mkEnableOption "service: headscale";
		port = lib.mkOption {
			description = "The exposed port";
			type = lib.types.int;
		};

		webui = {
			enable = lib.mkEnableOption "service: headscale-webui";
			port = lib.mkOption {
				description = "The exposed port";
				type = lib.types.int;
			};
		};
	};

	config = lib.mkIf serviceCfg.enable {
		services.caddy = {
			virtualHosts."hs.${domainName}".extraConfig = ''
				${webuiReverseProxy}
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
					base_domain = "ts.net";
				};

				noise.private_key_path = "/var/lib/headscale/noise_private.key";
			};
		};

		virtualisation.oci-containers = with serviceCfg.webui; lib.mkIf enable {
			containers.headscale-webui = {
				image = "ghcr.io/gurucomputing/headscale-ui:latest";
				ports = [ "127.0.0.1:${toString port}:8080" ];
				pull = "newer";
			};
		};
	};
}
