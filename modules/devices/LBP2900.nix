{ pkgs, ... }:
{
	# Enable printing using CUPS
	services.printing.enable = true;

	# Add drivers for the Canon LBP2900 printer
	services.printing.drivers = with pkgs; [ canon-capt ];
}
