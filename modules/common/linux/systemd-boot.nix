{ lib, config, ... }:
let
	cfg = config.modules.systemd-boot;
in
{
	options.modules.systemd-boot = {
		enable = lib.mkEnableOption "systemd-boot";
		limit = lib.mkOption {
			type = lib.types.int;
			default = 7;
			description = "The maximum number of boot configurations";
		};
	};

	config = lib.mkIf cfg.enable {
		boot.loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot = {
				enable = true;
				configurationLimit = cfg.limit;
			};
		};
	};
}
