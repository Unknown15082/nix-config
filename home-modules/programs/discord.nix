{ lib, config, pkgs, ... }:
let
	cfg = config.modules.discord;
in
{
	options.modules.discord = {
		enable = lib.mkEnableOption "Discord";
		addons = lib.mkEnableOption "Discord addons - Vesktop";
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			(if cfg.addons then pkgs.vesktop
			else pkgs.discord)
		];
	};
}
