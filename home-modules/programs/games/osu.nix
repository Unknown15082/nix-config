{ lib, config, inputs, system, ... }:
let
	cfg = config.modules.games.osu;
in
{
	options.modules.games.osu = {
		enable = lib.mkEnableOption "osu!";
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			(inputs.nix-gaming.packages.${system}.osu-stable.override {
				location = "/mnt/osu/.osu";
			})
		];
	};
}
