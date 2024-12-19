{ lib, mylib, config, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	config = lib.mkIf cfg.enable {
		programs.alacritty = {
			enable = true;
			settings = {
				font = {
					size = lib.mkForce 14;
					bold = {
						family = "JetBrainsMono Nerd Font Mono";
						style = "Bold";
					};

					bold_italic = {
						family = "JetBrainsMono Nerd Font Mono";
						style = "Bold Italic";
					};

					italic = {
						family = "JetBrainsMono Nerd Font Mono";
						style = "Italic";
					};

					normal = {
						family = "JetBrainsMono Nerd Font Mono";
						style = "Regular";
					};
				};

				env.TERM = "xterm-256color";
				colors.draw_bold_text_with_bright_colors = true;

				# Custom catppuccin-mocha color override
				colors.primary.background = lib.mkForce "#000000";
			};

			catppuccin = {
				enable = true;
				flavor = "mocha";
			};
		};
	};
}
