{ lib, config, ... }:
let
	cfg = config.modules.spotify-player;
in
{
	options.modules.spotify-player = {
		enable = lib.mkEnableOption "spotify-player";
	};

	config = lib.mkIf cfg.enable {
		# Thanks Mr.aome for creating spotify-player
		programs.spotify-player = {
			enable = true;
			settings = {
				theme = "catppuccin_mocha";
				# TODO: Add additional settings
				# TODO: Manage client_id using agenix
			};
		};
	};
}
