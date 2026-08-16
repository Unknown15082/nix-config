{ ... }: {
	flake.modules.homeManager.spotifyPlayer = {
		programs.spotify-player = {
			enable = true;
			# TODO: Add client_id_command
		};
	};

	flake.modules.homeManager.playerctl = { pkgs, ... }: {
		services.playerctld.enable = true;

		home.packages = [ pkgs.playerctl ];
	};
}
