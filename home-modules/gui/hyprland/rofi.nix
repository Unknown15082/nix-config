{ lib, utils, config, pkgs, ... }:
let
	cfg = config.modules.rofi;
in
{
	options.modules.rofi = {
		enable = utils.mkEnableTrueOption "Rofi (Wayland)";
	};

	config = lib.mkIf cfg.enable {
		programs.rofi = {
			enable = true;
			package = pkgs.rofi;

			terminal = "${pkgs.alacritty}/bin/alacritty";

			theme = utils.relativeToRoot "configs/rofi/launcher.rasi";
		};
	};
}
