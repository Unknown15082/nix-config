{ self, ... }: {
	flake.modules.homeManager.baseUser = {
		imports = with self.modules.homeManager; [
			modernUnix
			tmux
			nixtools
			nh
		];
	};

	flake.modules.homeManager.desktopUser = {
		imports = with self.modules.homeManager; [
			baseUser

			ime
			imeJapanese
			imeVietnamese

			ghostty
			discord
			spotifyPlayer
			playerctl
			firefox
		];
	};
}
