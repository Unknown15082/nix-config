{ lib, config, pkgs, ... }:
let
	cfg = config.modules.hyprland;
in
{
	options.modules.hyprland = {
		enable = lib.mkEnableOption "Hyprland";
	};

	config = lib.mkIf cfg.enable {
		programs.alacritty.enable = true;
		programs.kitty.enable = true;

		wayland.windowManager.hyprland = {
			enable = true;
		};
	};
}
