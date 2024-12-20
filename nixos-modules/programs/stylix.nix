{ lib, mylib, config, pkgs, ... }:
let
	cfg = config.modules.stylix;

	theme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
	wallpaper = mylib.relativeToRoot "configs/wallpaper/wallpaper.png";
in
{
	options.modules.stylix = {
		enable = lib.mkEnableOption "Stylix";
	};

	config = lib.mkIf cfg.enable {
		stylix = {
			enable = true;
			homeManagerIntegration = {
				autoImport = true;
				followSystem = true;
			};

			base16Scheme = theme;
			override = {
				base00 = "#000000";
			};
			image = wallpaper;
			polarity = "dark";

			cursor = {
				name = "Bibata-Modern-Ice";
				package = pkgs.bibata-cursors;
				size = 24;
			};

			fonts = {
				monospace = {
					name = "JetBrainsMono Nerd Font Mono";
					package = pkgs.nerd-fonts.jetbrains-mono;
				};

				sansSerif = {
					name = "DejaVu Sans";
					package = pkgs.dejavu_fonts;
				};

				serif = config.stylix.fonts.sansSerif;

				emoji = {
					name = "Noto Color Emoji";
					package = pkgs.noto-fonts-emoji;
				};

				sizes = {
					terminal = 14;
				};
			};
		};
	};
}
