{ lib, utils, config, pkgs, ... }:
let
	cfg = config.modules.osd;
in {
	options.modules.osd = {
		enable = utils.mkEnableTrueOption "SwayOSD";
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			swayosd
			brightnessctl
			jq
		];
	};
}
