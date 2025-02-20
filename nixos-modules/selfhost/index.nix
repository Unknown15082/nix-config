{ lib, config, ... }:
let
	cfg = config.modules.selfhost;
	serviceCfg = cfg.services.index;
	domainName = cfg.domainName;
in {
	options.modules.selfhost.services.index = {
		enable = lib.mkEnableOption "service: index";
	};

	config = lib.mkIf serviceCfg.enable {
		services.caddy = {
			virtualHosts."${domainName}".extraConfig = ''
				respond "Index page"
			'';
		};
	};
}
