{ outputs, config, pkgs, ... }:
{
	home.username = "unknown";
	home.homeDirectory = "/home/unknown";

	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	# Add NixVim
	imports = [ outputs.hmModules.nixvim ];

	# Add fastfetch
	home.packages = with pkgs; [
		fastfetch
	];
}
