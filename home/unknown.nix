{ inputs, outputs, config, pkgs, ... }:
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
		# Modern Unix tools
		fastfetch
		btop
		dust
		duf
		ripgrep
		lazygit

		openfortivpn		# Connecting with SoC VPN (NUS)
		hugo				# Blog sites
		zoom-us				# Zoom meetings
		zathura				# Viewing PDFs with VimTex
		xournalpp			# Tablet sketching
		obsidian			# Note-taking and tasks tracking

		qmk					# QMK programming

		# Personal NixVim config
		inputs.nixvim-config.packages.${system}.default
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
