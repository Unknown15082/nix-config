{ lib, mylib, config, pkgs, ... }:
let
	cfg = config.modules.stylix;

	theme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
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
			override = {
				base00 = "000000";
			};
			image = wallpaper;
			polarity = "dark";

			autoEnable = false;
		};
	};
}
