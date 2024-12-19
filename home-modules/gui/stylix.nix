{ lib, osConfig, ... }:
let
	cfg = osConfig.modules.stylix;
in
{
	config = lib.mkIf cfg.enable {
		stylix = {
			enable = true;
			autoEnable = false;

			targets.hyprland = {
				enable = true;
				hyprpaper.enable = true;
			};
			targets.hyprpaper.enable = true;
		};
	};
}
