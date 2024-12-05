# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, lib, config, pkgs, ... }:

{
	imports =
	[
		# Include the results of the hardware scan.
		./hardware-configuration.nix

		# Include laptop-specific configs
		./laptop.nix

		# Add nix-index-database
		inputs.nix-index-database.nixosModules.nix-index
	];

	# Enable specific configs for local devices
	modules.devices.LBP2900.enable = true;

	# Enable OpenTabletDriver
	hardware.opentabletdriver.enable = true;

	# Include the laptop keyboard ID for KeyD
	modules.keyd.keyboardIds = [ "048d:c966" ];

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

	# Enable fish shell
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.unknown = {
		isNormalUser = true;
		description = "Unknown";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
	};

	# Install firefox.
	programs.firefox.enable = true;

	# Enable flakes and the new Nix CLI
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Set Nix PATH for nixd
	nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		git
		gcc
		wl-clipboard
		gnupg
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
		nerd-fonts.jetbrains-mono
	];

	# Enable GPG
	programs.gnupg = {
		agent = {
			enable = true;
			enableSSHSupport = true;
			enableBrowserSocket = true;
			enableExtraSocket = true;
		};
	};

	# Disable command-not-found
	programs.command-not-found.enable = false;
}
