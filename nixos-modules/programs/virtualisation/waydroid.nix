{ lib, mylib, config, pkgs, username, ... }:
let
	cfg = config.modules.virtualisation.waydroid;
in
{
	options.modules.virtualisation.waydroid = {
		enable = mylib.mkEnableTrueOption "Waydroid";
	};

	config = lib.mkIf cfg.enable {
		virtualisation.waydroid.enable = true;
	};
}
