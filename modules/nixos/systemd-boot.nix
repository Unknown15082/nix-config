{ pkgs, ... }:
{
	# Configure systemd-boot
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 7;

	# Configure the Linux kernel (TODO: Move to another module)
	boot.kernelPackages = pkgs.linuxPackages_zen;
}
