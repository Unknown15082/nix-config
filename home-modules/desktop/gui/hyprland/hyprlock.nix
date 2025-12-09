{ lib, utils, config, ... }:
let
	cfg = config.modules.hyprlock;
in {
	options.modules.hyprlock = {
		enable = utils.mkEnableTrueOption "Hyprlock";
	};

	config = lib.mkIf cfg.enable {
		programs.hyprlock = {
			enable = true;
			settings = {}; # TODO: Config hyprlock
		};
	};
}
