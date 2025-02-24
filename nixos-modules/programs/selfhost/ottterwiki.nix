{ lib, config, ... }:
let
	cfg = config.modules.selfhost;
	serviceCfg = cfg.services.otterwiki;
	domainName = cfg.domainName;
in {
	options.modules.selfhost.services.otterwiki = {
		enable = lib.mkEnableOption "service: otterwiki";
		dataPath = lib.mkOption {
			description = "The data path to be mounted";
			type = lib.types.str;
			default = "/etc/otterwiki/data";
		};
		port = lib.mkOption {
			description = "The exposed port";
			type = lib.types.int;
		};
		environmentFiles = lib.mkOption {
			description = "Additional environment variables";
			type = lib.types.listOf lib.types.str;
			default = [];
		};
	};

	config = lib.mkIf serviceCfg.enable {
		services.caddy = {
			virtualHosts."wiki.${domainName}".extraConfig = ''
				reverse_proxy :${toString serviceCfg.port}
			'';
		};

		virtualisation.oci-containers = with serviceCfg; {
			containers.otterwiki = {
				image = "redimp/otterwiki:2-slim";
				ports = [ "127.0.0.1:${toString port}:8080" ];
				volumes = [
					"${dataPath}:/app-data"
				];
				inherit environmentFiles;
			};
		};
	};
}
