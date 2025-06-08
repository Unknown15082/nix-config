{ inputs, config, osConfig, lib, pkgs, username, ... }:
{
	home.username = "${username}";
	home.homeDirectory = "/home/${username}";

	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	# Add packages
	home.packages = with pkgs; [
		# Essential tools
		firefox
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
		just
		gcalcli
		nchat

		# Coding stuff
		# TODO: Move to specific devshells
		jetbrains.idea-community-bin
		jdk
		vscode

		# Personal NixVim config
		inputs.nixvim-config.packages.${system}.default

		# Agenix CLI
		inputs.agenix.packages.${system}.default
	];

	# Setup git
	programs.git = {
		enable = true;
		userName = "Unknown15082";
		userEmail = "trangiahuy15082006@gmail.com";

		signing = {
			key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
			format = "ssh";
			signByDefault = true;
		};

		aliases = {
			amend = "commit --amend --no-edit";
			aliases = "config --get-regexp alias";
		};

		extraConfig = {
			core = {
				excludesFile = "${config.home.homeDirectory}/.gitignore";
			};
		};
	};

	# Neovim as default
	home.sessionVariables = {
		EDITOR = "nvim";
	};

	# Enable Discord
	modules.discord.enable = true;
	modules.discord.addons = true;

	# Enable spotify-player
	modules.spotify-player.enable = true;

	# Use ghostty instead of alacritty
	modules.ghostty.enable = true;
}
