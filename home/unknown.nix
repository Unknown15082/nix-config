{ config, pkgs, ... }:
{
	home.username = "unknown";
	home.homeDirectory = "/home/unknown";

	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	# Configure neovim
	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	# Add fastfetch
	home.packages = with pkgs; [
		fastfetch
	];
}
