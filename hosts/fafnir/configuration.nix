# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, config, pkgs, pkgs-unstable, ... }:

{
	imports =
	[
		# Include the results of the hardware scan.
		./hardware-configuration.nix

		# Include laptop-specific configs
		./laptop.nix
	] ++ ( with outputs.nixosModules; [
		# Include NVIDIA configs
		nvidia

		# Include systemd-boot configs
		systemd-boot

		# Include games (osu!)
		osu-lazer
		
		# Include discord
		discord

		# Include AAGL
		aagl

		# Include keyd configs
		keyd

		# Add docker
		docker

		# Sound settings
		sound

		# Locale settings
		locale

		# Bluetooth settings
		bluetooth
	]);

	# Enable printing using CUPS
	services.printing.enable = true;

	# Add additional printing drivers for a Canon LBP2900 printer
	services.printing.drivers = with pkgs; [ canon-capt ];

	# Set the kernel version
	boot.kernelPackages = pkgs-unstable.linuxPackages_zen;

	# Enable networking
	networking.networkmanager.enable = true;

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.unknown = {
		isNormalUser = true;
		description = "Unknown";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [
		#  thunderbird
		];
	};

	# Install firefox.
	programs.firefox.enable = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Enable flakes and the new Nix CLI
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		git
		gcc
	];

	# Enable Gamemode
	programs.gamemode.enable = true;

	# Enable Gamescope
	programs.gamescope = {
		enable = true;
		capSysNice = true;
	};

	# Enable Tailscale
	services.tailscale.enable = true;

	system.stateVersion = "23.11"; # Leave this option alone

	# Manage fonts
	fonts.packages = with pkgs; [
		jetbrains-mono
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];
}
