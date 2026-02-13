{ lib, config, ... }:
let
	cfg = config.modules.alacritty;
in
{
	options.modules.alacritty = {
		enable = lib.mkEnableOption "Alacritty";
	};

	config = lib.mkIf cfg.enable {
		programs.alacritty = {
			enable = true;
			settings = {
				env.TERM = "xterm-256color";
			};
		};
	};
}
