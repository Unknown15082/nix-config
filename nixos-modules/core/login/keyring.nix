{ lib, config, pkgs, ... }:
let
	cfg = config.modules.keyring;
in
{
	options.modules.keyring = {
		enable = lib.mkEnableOption "GNOME Keyring" // { default = true; };
	};

	config = lib.mkIf cfg.enable {
		services.gnome.gnome-keyring.enable = true;
		environment.systemPackages = [ pkgs.libsecret ];
		services.dbus.packages = [ pkgs.seahorse ];
	};
}
