{ self, ... }: {
	flake.modules.homeManager.imeSettings = { lib, ... }: {
		options.settings.ime = {
			methods = with lib; mkOption {
				type = types.listOf types.str;
				default = [];
			};
		};
	};

	flake.modules.homeManager.ime = { lib, config, ... }: let
		cfg = config.settings.ime;
	in {
		imports = [
			self.modules.homeManager.imeSettings
		];

		i18n.inputMethod = {
			enable = true;
			type = "fcitx5";

			fcitx5 = {
				waylandFrontend = true;

				settings = {
					globalOptions = {};

					inputMethod = lib.mkMerge [
						{
							"Groups/0" = {
								Name = "Default";
								DefaultIM = "keyboard-us-altgr-intl";
								"Default Layout" = "us-altgr-intl";
							};
						}
						(
							lib.imap0
							(i: name: {
								name = "Groups/0/Items/${i}";
								value.Name = name;
							})
							([ "keyboard-us-altgr-intl" ] ++ cfg.methods)
						)
					];
				};
			};
		};

		catppuccin.fcitx5.enable = true;
	};

	flake.modules.homeManager.imeJapanese = { pkgs, ... }: {
		i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-mozc-ut ];
		settings.ime.methods = [ "mozc" ];
	};

	flake.modules.homeManager.imeVietnamese = { pkgs, ... }: {
		i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-bamboo ];
		settings.ime.methods = [ "bamboo" ];
	};
}
