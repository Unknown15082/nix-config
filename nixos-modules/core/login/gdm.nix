{ lib, config, ... }:
let
	cfg = config.modules.gdm;
in
{
	options.modules.gdm = {
		enable = lib.mkEnableOption "GDM" // { default = true; };
		enableKeyring = lib.mkEnableOption "keyring" // { default = cfg.enable; };
	};

	config = lib.attrsets.recursiveUpdate (lib.mkIf cfg.enable {
		services.xserver = {
			enable = true;
			displayManager.gdm = {
				enable = true;
				wayland = true;
			};
		};
	}) (lib.mkIf cfg.enableKeyring {
		services.gnome.gnome-keyring.enable = true;
		security.pam.services.gdm-password.enableGnomeKeyring = true;
		programs.seahorse.enable = true;
	});
}
