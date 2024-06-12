{ pkgs, ... }:

{
	# Enable printing using CUPS
	services.printing.enable = true;

	# Add additional drivers
	services.printing.drivers = with pkgs; [ canon-capt ];

	# In order to change the model of the printers,
	# go to localhost:631, choose Modify Printer,
	# then change the model to LBP2900.
}
