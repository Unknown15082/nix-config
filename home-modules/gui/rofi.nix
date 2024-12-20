{ lib, mylib, config, pkgs, ... }:
let
	cfg = config.modules.rofi;
in
{
	options.modules.rofi = {
		enable = mylib.mkEnableTrueOption "Rofi (Wayland)";
	};

	config = lib.mkIf cfg.enable {
		programs.rofi = {
			enable = true;
			package = pkgs.rofi-wayland;

			terminal = "${pkgs.alacritty}/bin/alacritty";
		};
	};
}
