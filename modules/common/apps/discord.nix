{ lib, config, pkgs, ... }:
let
	cfg = config.modules.discord;
in
{
	options.modules.discord = {
		enable = lib.mkEnableOption "Discord";
		addons = lib.mkEnableOption "Discord addons";
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			(if cfg.addons then
				(pkgs.discord.override {
					withOpenASAR = true;
					withVencord = true;
					withTTS = true;
				})
			else pkgs.discord)
		];
	};
}
