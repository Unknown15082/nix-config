{ lib, config, ... }:
let
	cfg = config.modules.caelestia;
in
{
	options.modules.caelestia = {
		enable = lib.mkEnableOption "caelestia-dots";
	};

	config = lib.mkIf cfg.enable {
		programs.caelestia = {
			enable = true;
			cli.enable = true;
		};
	};
}
