{ lib, ... }:
{
	imports = [
		./steam.nix
		./discord.nix
	];

	modules.steam.enable = lib.mkDefault true;

	modules.discord.enable = lib.mkDefault true;
	modules.discord.addons = lib.mkDefault true;
}
