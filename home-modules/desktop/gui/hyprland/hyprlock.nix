{ lib, libutils, config, ... }:
let
	cfg = config.modules.hyprlock;
in {
	options.modules.hyprlock = {
		enable = lib.mkEnableOption "Hyprlock";
	};

	config = lib.mkIf cfg.enable {
		programs.hyprlock = {
			enable = true;
			settings = {}; # TODO: Config hyprlock
		};
	};
}
