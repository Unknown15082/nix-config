{ lib, config, pkgs, ... }:
let
  cfg = config.modules.qmk;
in
{
	options.modules.qmk = {
		enable = lib.mkEnableOption "qmk";
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			qmk
		];

		services.udev.packages = [ pkgs.qmk-udev-rules ];
	};
}
