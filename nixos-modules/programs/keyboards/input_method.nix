{ lib, config, pkgs, ... }:
let
	cfg = config.modules.keyboards.input-method;
in
{
	options.modules.keyboards.input-method = {
		vietnamese = {
			enable = lib.mkEnableOption "Vietnamese input method";
		};
	};

	config = lib.mkIf cfg.vietnamese.enable {
		i18n.inputMethod = {
			enable = true;
			type = "fcitx5";
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

		catppuccin.fcitx5 = {
			enable = true;
			flavor = "mocha";
		};

		environment.systemPackages = lib.optionals config.modules.gnome.enable [ pkgs.gnomeExtensions.kimpanel ];
	};
}
