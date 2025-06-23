{ lib, mylib, config, ... }:
let
	cfg = config.modules.waybar;
in {
	options.modules.waybar = {
		enable = mylib.mkEnableTrueOption "Waybar";
	};

	config = lib.mkIf cfg.enable {
		programs.waybar = {
			enable = true;
			systemd.enable = true;
			
			settings.mainBar = {
				modules-left = [
					"hyprland/workspaces"
				];
				modules-center = [
					"clock"
				];
				modules-right = [
					"battery"
					"tray"
				];
			};
		};
	};
}
