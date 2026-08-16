{ self, ... }: {
	flake.modules.nixos.presets-games = {
		imports = with self.modules.nixos; [
			games-nix-gaming
			games-gamemode
			games-ntsync
		];
	};
}
