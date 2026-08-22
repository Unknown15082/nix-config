{ self, ... }: {
	flake.modules.nixos.locale = {
		i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" ];
		i18n.extraLocaleSettings = {
			LC_TIME = "en_GB.UTF-8";
		};
	};

	flake.modules.nixos.timezone = {
		services.automatic-timezoned.enable = true;
	};

	flake.modules.nixos.allFonts = {
		imports = with self.modules.nixos; [ codeFonts cjkFonts emojiFonts ];
	};

	flake.modules.nixos.codeFonts = { pkgs, ... }: {
		fonts.packages = with pkgs; [
			jetbrains-mono
			nerd-fonts.jetbrains-mono
		];
	};

	flake.modules.nixos.cjkFonts = { pkgs, ... }: {
		fonts.packages = with pkgs; [
			dejavu_fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
		];
	};

	flake.modules.nixos.emojiFonts = { pkgs, ... }: {
		fonts.packages = with pkgs; [
			noto-fonts-color-emoji
		];
	};

	flake.modules.nixos.iconTheme = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			adwaita-icon-theme
		];
	};
}
