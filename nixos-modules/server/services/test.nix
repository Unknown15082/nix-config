{ lib, config, ... }:
let
	cfg = config.modules.services;
	serviceCfg = cfg.services.test;
	domainName = cfg.domainName;
in {
	options.modules.services.services.test = {
		enable = lib.mkEnableOption "service: test";
	};

	config = lib.mkIf serviceCfg.enable {
		services.caddy = {
			virtualHosts."test.${domainName}".extraConfig = ''
				respond "Testing"
			'';
		};
	};
}
