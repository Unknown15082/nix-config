{ lib, config, pkgs, ... }:
let
	cfg = config.modules.printing;
in
{
	options.modules.printing = {
		enable = lib.mkEnableOption "Printing";
	};

	config = lib.mkIf cfg.enable {
		# Enable printing using CUPS
		services.printing.enable = true;

		# Add drivers for the Canon LBP2900 printer
		services.printing.drivers = with pkgs; [ canon-capt ];
	};
}
