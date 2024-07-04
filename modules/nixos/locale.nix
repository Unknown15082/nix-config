{ pkgs, ... }:
{
	# Setup locales
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_TIME = "en_DK.UTF-8";
	};

	# Enable Vietnamese input method
	/*i18n.inputMethod = {
		enabled = "ibus";
		ibus.engines = with pkgs.ibus-engines; [ bamboo ];
	};*/

	# Automatically setup timezone
	services.automatic-timezoned.enable = true;
}
