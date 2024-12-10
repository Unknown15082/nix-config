{ lib, config, pkgs, ... }:
let
	cfg = config.modules.hyprland;
in
{
	options.modules.hyprland = {
		enable = lib.mkEnableOption "Hyprland";
		package = lib.mkOption {
			type = lib.types.package;
			description = "Package for Hyprland";
		};
	};

	config = lib.mkIf cfg.enable {
		programs.alacritty.enable = true;
		programs.kitty.enable = true;

		wayland.windowManager.hyprland = {
			enable = true;
			settings = {
				"$mod" = "SUPER";
				bind = [
					"$mod, C, exec, firefox"
					"$mod, Q, exec, kitty"
				];
			};
		};
	};
}
