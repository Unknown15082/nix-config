{ lib, config, ... }:
let
	cfg = config.modules.gdm;
in
{
	options.modules.gdm = {
		enable = lib.mkEnableOption "GDM";
	};

	config = lib.mkIf cfg.enable {
		services.xserver = {
			enable = true;
			displayManager.gdm = {
				enable = true;
				wayland = true;
			};
		};
	};
}
