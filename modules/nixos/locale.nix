{ pkgs, ... }:
{
	# Setup locales
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_TIME = "en_DK.UTF-8";
	};

	# TODO: Move to home-manager
	# Enable Vietnamese input method
	i18n.inputMethod = {
		enabled = "fcitx5";
		fcitx5 = {
			addons = [ pkgs.fcitx5-bamboo ];
			waylandFrontend = true;

			settings.inputMethod = {
				"Groups/0" = {
					"Name" = "Default";
					"Default Layout" = "us-altgr-intl";
					"DefaultIM" = "keyboard-us-altgr-intl";
				};
				"Groups/0/Items/0" = { "Name" = "keyboard-us-altgr-intl"; };
				"Groups/0/Items/1" = { "Name" = "bamboo"; };
			};
		};
	};

	# Add kimpanel for Gnome to indicate current layout
	# TODO: Enable this only if config.locale.languages.vietnamese and config.DE.gnome is both enabled

	environment.systemPackages = with pkgs.gnomeExtensions; [ kimpanel ];

	# Automatically setup timezone
	services.automatic-timezoned.enable = true;
}
