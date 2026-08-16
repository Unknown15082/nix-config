{ self, ... }: {
	flake.modules.homeManager.baseUser = {
		imports = with self.modules.homeManager; [
			fish
			modernUnix
			nixtools
		];
	};

	flake.modules.homeManager.desktopUser = {
		imports = with self.modules.homeManager; [
			baseUser

			ime
			imeJapanese
			imeVietnamese
			keyd

			ghostty
			discord
			spotifyPlayer
			playerctl
			firefox
		];
	};
}
