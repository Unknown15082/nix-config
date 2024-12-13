{ lib, config, ... }:
let
	cfg = config.modules.sddm;
in
{
	options.modules.sddm = {
		enable = lib.mkEnableOption "SDDM" // { default = true; };
		enableKeyring = lib.mkEnableOption "keyring" // { default = cfg.enable; };
	};

	config = lib.attrsets.recursiveUpdate (lib.mkIf cfg.enable {
		services.displayManager = {
			sddm = {
				enable = true;
				wayland.enable = true;
			};
		};
	}) (lib.mkIf cfg.enableKeyring {
		services.gnome.gnome-keyring.enable = true;
		security.pam.services.sddm.enableGnomeKeyring = true;
		programs.seahorse.enable = true;
	});
}
