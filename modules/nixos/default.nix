{
	systemd-boot = import ./systemd-boot.nix;
	osu-lazer = import ./osu-lazer.nix;
	discord = import ./discord.nix;
	nvidia = import ./nvidia.nix;
	keyd = import ./keyd.nix;
	docker = import ./docker.nix;
	locale = import ./locale.nix;
}
