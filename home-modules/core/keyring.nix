{ lib, config, ... }:
let
	cfg = config.modules.keyring;
in
{
	options.modules.keyring = {
		enable = lib.mkEnableOption "GNOME Keyring" // { default = true; };
	};

	config = lib.mkIf cfg.enable {
		services.gnome-keyring = {
			enable = true;
			components = [ "pkcs11" "secrets" "ssh" ];
		};
	};
}
