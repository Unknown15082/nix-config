{ lib, config, ... }:
let
	cfg = config.modules.sddm;
in
{
	options.modules.sddm = {
		enable = lib.mkEnableOption "SDDM";
	};

	config = lib.mkIf cfg.enable {
		services.displayManager = {
			sddm = {
				enable = true;
				wayland.enable = true;
			};
		};
	};
}
