{ lib, config, pkgs, ... }:
let
	cfg = config.modules.games.ffxiv;
in {
	options.modules.games.ffxiv = {
		enable = lib.mkEnableOption "FFXIV";
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			xivlauncher
		];
	};
}
