{ lib, mylib, config, pkgs, ... }:
let
	cfg = config.modules.stylix;

	theme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
	rawWallpaper = mylib.relativeToRoot "configs/wallpaper/NeutronStar.jpg";

	wallpaper = pkgs.runCommand "wallpaper.png" {} ''
		COLOR=$(${pkgs.yq}/bin/yq -r .base03 ${theme})
		COLOR="#"$COLOR
		${pkgs.imagemagick}/bin/magick ${rawWallpaper} $out
	'';
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
			image = wallpaper;
			polarity = "dark";

			fonts = {
				monospace = {
					package = pkgs.nerd-fonts.jetbrains-mono;
					name = "JetBrainsMono Nerd Font Mono";
				};

				sizes = {
					terminal = 14;
				};
			};
		};
	};
}
