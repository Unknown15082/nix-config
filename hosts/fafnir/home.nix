{ inputs, osConfig, lib, pkgs, username, ... }:
{
	home.username = "${username}";
	home.homeDirectory = "/home/${username}";

	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	# Add packages
	home.packages = with pkgs; [
		# Essential tools
		firefox
		git
		gcc
		wl-clipboard
		gnupg

		# Other tools
		openfortivpn		# Connecting with SoC VPN (NUS)
		hugo				# Blog sites
		zoom-us		# Zoom meetings
		zathura				# Viewing PDFs with VimTex
		xournalpp			# Tablet sketching
		obsidian				# Note-taking and tasks tracking
		gparted
		mpv

		# Coding stuff
		# TODO: Move to specific devshells
		jetbrains.idea-community-bin
		jdk

		# Personal NixVim config
		inputs.nixvim-config.packages.${system}.default
	];

	# Enable kimpanel
	dconf = lib.mkIf osConfig.modules.gnome.enable {
		enable = true;
		settings."org/gnome/shell" = {
			disable-user-extensions = false;
			enabled-extensions = with pkgs.gnomeExtensions; [
				hide-top-bar.extensionUuid
				kimpanel.extensionUuid
			];
		};
	};

	# Enable osu!stable
	modules.games.osu.enable = true;
}
