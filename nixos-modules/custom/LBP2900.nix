{ lib, config, pkgs, ... }:
let
	cfg = config.modules.devices.LBP2900;
in
{
	options.modules.devices.LBP2900 = {
		enable = lib.mkEnableOption "Canon LBP2900 printer";
	};

	config = lib.mkIf cfg.enable {
		# Enable printing using CUPS
		services.printing.enable = true;

		# Add drivers for the Canon LBP2900 printer
		services.printing.drivers = with pkgs; [ canon-capt ];
	};
}
