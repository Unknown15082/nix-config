{ outputs, config, pkgs, ... }:
{
	imports = [
		../modules/home
	];

	home.username = "unknown";
	home.homeDirectory = "/home/unknown";

	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	# Add packages
	home.packages = with pkgs; [
		fastfetch
		btop
		dust
		duf

		openfortivpn
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

	# Setup direnv
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
		silent = true;
		enableBashIntegration = true;
	};
}
