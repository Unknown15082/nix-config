{ lib, config, ... }:
let
	cfg = config.presets.desktop;
in {
	options.presets.desktop = {
		enable = lib.mkEnableOption "desktop preset";
	};

	config = lib.mkIf cfg.enable {
		modules = {
			kernel.enable = true;
			systemd-boot.enable = true;
			nix-settings.enable = true;
			nvidia = {
				enable = true;
				beta = true;
				offload = true;
				sync = false;
			};

			bluetooth.enable = true;
			printing.enable = true;
			sound.enable = true;
			networking = {
				enable = true;
				nameservers.google = true;
			};
			
			sddm.enable = true;
			stylix.enable = true;
			nh.enable = true;
		};
	};
}
