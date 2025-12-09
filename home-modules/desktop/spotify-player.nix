{ lib, config, osConfig, ... }:
let
	cfg = config.modules.spotify-player;
in
{
	options.modules.spotify-player = {
		enable = lib.mkEnableOption "spotify-player";
	};

	config = lib.mkIf cfg.enable {
		# Thanks aome for creating spotify-player
		programs.spotify-player = {
			enable = true;
			settings = {
				client_id_command = "cat ${osConfig.age.secrets.spotify_client_id.path}";
			};
		};
	};
}
