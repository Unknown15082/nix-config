{ self, pkgs, ... }: {
	flake.modules.nixos.locale = {
		i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" ];
		i18n.extraLocaleSettings = {
			LC_TIME = "en_GB.UTF-8";
		};
	};

	flake.modules.nixos.fonts.all = {
		imports = with self.modules.nixos.fonts; [ code cjk ];
	};

	flake.modules.nixos.fonts.code = {
		fonts.packages = with pkgs; [
			jetbrains-mono
			nerd-fonts.jetbrains-mono
		];
	};

	flake.modules.nixos.fonts.cjk = {
		fonts.packages = with pkgs; [
			dejavu_fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
		];
	};
}
