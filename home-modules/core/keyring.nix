{ lib, osConfig, ... }:
let
	cfg = osConfig.modules.keyring;
in
{
	config = lib.mkIf cfg.enable {
		services.gnome-keyring = {
			enable = true;
			components = [ "pkcs11" "secrets" "ssh" ];
		};
	};
}
