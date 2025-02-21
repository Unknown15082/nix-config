{ lib, config, ... }:
let
	cfg = config.modules.selfhost;
	serviceCfg = cfg.services.test;
	domainName = cfg.domainName;
in {
	options.modules.selfhost.services.test = {
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
