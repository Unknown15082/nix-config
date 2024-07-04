{
	/*imports = [
		./bluetooth.nix
		./sound.nix
	];*/

	systemd-boot = import ./systemd-boot.nix;
	osu-lazer = import ./osu-lazer.nix;
	discord = import ./discord.nix;
	aagl = import ./aagl.nix;
	nvidia = import ./nvidia.nix;
	keyd = import ./keyd.nix;
	docker = import ./docker.nix;
	locale = import ./locale.nix;

	/*
	modules.bluetooth.enable = lib.mkDefault true;

	modules.sound.enable = lib.mkDefault true;
	modules.sound.low-latency.enable = lib.mkDefault true;
	*/
}
