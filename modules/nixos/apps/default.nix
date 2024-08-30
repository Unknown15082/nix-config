{ lib, ... }:
{
	imports = [
		./steam.nix
		./discord.nix
		./docker.nix
		./keyd.nix
	];

	modules.steam.enable = lib.mkDefault true;

	modules.discord.enable = lib.mkDefault true;
	modules.discord.addons = lib.mkDefault true;

	modules.docker.enable = lib.mkDefault true;

	modules.keyd.enable = lib.mkDefault true;
}
