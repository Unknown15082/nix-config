# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, system, lib, config, pkgs, ... }:

{
	imports =
	[
		# Include the results of the hardware scan.
		./hardware-configuration.nix

		# Include laptop-specific configs
		./laptop.nix
	];

	# Enable specific configs for local devices
	modules.devices.LBP2900.enable = true;

	# Enable NUSVPN
	modules.nusvpn.enable = true;

	# Enable OpenTabletDriver
	hardware.opentabletdriver.enable = true;

	# Set Windows' device handle for systemd-boot
	modules.systemd-boot.enable = true;
	modules.systemd-boot.windows_dual_boot = "HD0b";

	# Set the kernel version
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Enable networking
	networking.networkmanager = {
		enable = true;
		insertNameservers = [
			# Google
			"8.8.8.8"
			"8.8.4.4"
		];
	};

	# Enable some nix settings
	modules.nix-settings.enable = true;

	# Enable fish shell
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.unknown = {
		isNormalUser = true;
		uid = 1000;
		description = "Unknown";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
	};

	# Enable Gamemode
	programs.gamemode.enable = true;

	# Enable Gamescope
	programs.gamescope = {
		enable = true;
		capSysNice = true;
	};

	# Enable Tailscale
	services.tailscale = {
		enable = true;
		useRoutingFeatures = "client";
	};

	# Leave this option alone
	system.stateVersion = "23.11"; 

	# Manage fonts
	fonts.packages = with pkgs; [
		jetbrains-mono
		nerd-fonts.jetbrains-mono
		dejavu_fonts

		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
	];

	# Enable GPG
	programs.gnupg = {
		agent = {
			enable = true;
			enableBrowserSocket = true;
			enableExtraSocket = true;
		};
	};

	# Disable command-not-found
	programs.command-not-found.enable = false;

	# Enable Hyprland
	modules.hyprland.enable = true;

	# Enable bt-sync
	modules.bluetooth.bt-sync.windows_partition = "nvme0n1p3";

	# Enable stylix
	modules.stylix.enable = true;

	# Enable postgresql
	services.postgresql = {
		enable = true;
	};

	# Enable Nvidia
	modules.nvidia = {
		enable = true;
		beta = true;
		offload = true;
		sync = false;
	};

	# Enable sound server
	modules.sound.enable = true;

	# Enable nh (nix helper)
	modules.nh.enable = true;

	# Enable games
	modules.games.steam.enable = true;
	modules.games.osu.enable = true;
	modules.games.ffxiv.enable = true;

	# Enable Docker
	modules.virtualisation.docker.enable = true;

	# Enable keyboards modules
	modules.keyboards = {
		keyd = {
			enable = true;
			keyboardIds = [ "048d:c966" ];
		};
		qmk.enable = true;
		input-method.vietnamese.enable = true;
	};

	# Enable SSH
	services.openssh.enable = true;

	# Enable I2C
	hardware.i2c.enable = true;
}
