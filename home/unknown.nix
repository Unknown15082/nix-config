{ outputs, config, pkgs, ... }:
{
	home.username = "unknown";
	home.homeDirectory = "/home/unknown";

	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	# Add NixVim
	imports = [ outputs.hmModules.nixvim ];
	programs.nixvim.defaultEditor = true;

	# Add packages
	home.packages = with pkgs; [
		fastfetch
		btop
		dust
		duf
	];

	# Enable kimpanel
	dconf = {
		enable = true;
		settings."org/gnome/shell" = {
			disable-user-extensions = false;
			enabled-extensions = with pkgs.gnomeExtensions; [
				hide-top-bar.extensionUuid
				kimpanel.extensionUuid
			];
		};
	};
}
