{ config, ... }:
{
	# Enable the stock power management service
	powerManagement.enable = true;

	# Enable thermald to prevent overheat
	services.thermald.enable = true;

	# Disable ppd to avoid conflict with tlp
	services.power-profiles-daemon.enable = !config.services.tlp.enable;

	# Enable tlp
	services.tlp.enable = true;
}
