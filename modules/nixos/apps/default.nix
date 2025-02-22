{ lib, ... }:
{
	imports = [
		./discord.nix
		./docker.nix
		./keyd.nix
		./qmk.nix
	];

	modules.discord.enable = lib.mkDefault true;
	modules.discord.addons = lib.mkDefault true;

	modules.docker.enable = lib.mkDefault true;

	modules.keyd.enable = lib.mkDefault true;

	modules.qmk.enable = lib.mkDefault true;
}
