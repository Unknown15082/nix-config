{ config, pkgs, ... }:
{
	home.username = "unknown";
	home.homeDirectory = "/home/unknown";

	home.stateVersion = "24.05";
	programs.home-manager.enable = true;

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
}
