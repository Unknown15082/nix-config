{ lib, config, pkgs, ... }:
let
	cfg = config.modules.keyring;
in
{
	options.modules.keyring = {
		enable = lib.mkEnableOption "GNOME Keyring" // { default = true; };
	};

	config = lib.mkIf cfg.enable {
		programs.seahorse.enable = true;
		environment.systemPackages = [ pkgs.libsecret ];
	};
}
