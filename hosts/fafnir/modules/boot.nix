{ config, pkgs, ... }:

{
	# Configure systemd-boot
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
}
