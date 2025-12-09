{ lib, config, ... }:
let
	cfg = config.modules.nh;
in
{
	options.modules.nh = {
		enable = lib.mkEnableOption "nix-helper (nh)";
	};

	config = lib.mkIf cfg.enable {
		programs.nh = {
			enable = true;
			clean.enable = true;
			clean.extraArgs = "--keep-since 7d --keep 3";
			flake = "/home/unknown/nix-config/";
		};
	};
}
