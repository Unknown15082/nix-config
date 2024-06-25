{
	systemd-boot = import ./systemd-boot.nix;
	osu-lazer = import ./osu-lazer.nix;
	discord = import ./discord.nix;
	aagl = import ./aagl.nix;
	nvidia = import ./nvidia.nix;
	keyd = import ./keyd.nix;
}
