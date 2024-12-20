{ lib, mylib, config, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	config = lib.mkIf cfg.enable {
		programs.alacritty = {
			enable = true;
			settings = {
				env.TERM = "xterm-256color";

				# Custom catppuccin-mocha color override
				# colors.primary.background = lib.mkForce "#000000";
			};
		};
	};
}
