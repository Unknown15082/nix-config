{ lib, osConfig, ... }:
let
	cfg = osConfig.modules.stylix;
in
{
	config = lib.mkIf cfg.enable {
		stylix = {
			enable = true;
			autoEnable = false;

			targets.alacritty.enable = false;
		};
	};
}
