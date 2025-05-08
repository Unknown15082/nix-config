{ lib, config, username, ... }:
let
	cfg = config.modules.selfhost;
	serviceCfg = cfg.services.stirling-pdf;
	domainName = cfg.domainName;
in {
	options.modules.selfhost.services.stirling-pdf = {
		enable = lib.mkEnableOption "service: stirling-pdf";
		port = lib.mkOption {
			description = "The exposed port";
			type = lib.types.int;
		};
	};

	config = lib.mkIf serviceCfg.enable {
		services.caddy = {
			virtualHosts."spdf.${domainName}".extraConfig = ''
				reverse_proxy :${toString serviceCfg.port}
			'';
		};

		services.stirling-pdf = {
			enable = true;
			environment = {
				SERVER_PORT = serviceCfg.port;
				
				SECURITY_ENABLELOGIN = "true";
				SECURITY_INITIALLOGIN_USERNAME = "${username}";
			};
		};
	};
}
