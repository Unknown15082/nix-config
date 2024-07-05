# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, lib, config, pkgs, pkgs-stable, ... }:

{
	imports =
	[
		# Include the results of the hardware scan.
		./hardware-configuration.nix

		# Include laptop-specific configs
		./laptop.nix

		# Add configs for Canon LBP2900 printer
		outputs.devices.LBP2900
	]
	++ ( with outputs.nixosModules; [
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

		# Locale settings
		locale
	]) ++ [
		../../modules/nixos/bluetooth.nix
		../../modules/nixos/sound.nix
	];

	modules.bluetooth.enable = lib.mkDefault true;

	modules.sound.enable = lib.mkDefault true;
	modules.sound.low-latency.enable = lib.mkDefault true;

	# Set the kernel version
	boot.kernelPackages = pkgs.linuxPackages_zen;

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
		wl-clipboard
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
