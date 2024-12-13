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

		# Add nix-index-database
		inputs.nix-index-database.nixosModules.nix-index
	];

	# Enable specific configs for local devices
	modules.devices.LBP2900.enable = true;

	# Enable NUSVPN
	modules.nusvpn.enable = true;

	# Enable OpenTabletDriver
	hardware.opentabletdriver.enable = true;

	# Include the laptop keyboard ID for KeyD
	modules.keyd.keyboardIds = [ "048d:c966" ];

	# Set Windows' device handle for systemd-boot
	modules.systemd-boot.enable = true;
	modules.systemd-boot.windows_dual_boot = "HD0b";

	# Set the kernel version
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Enable networking
	networking.networkmanager.enable = true;

	# Enable fish shell
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.unknown = {
		isNormalUser = true;
		description = "Unknown";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
	};

	# Enable flakes and the new Nix CLI
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Set Nix PATH for nixd
	nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

	# Auto-optimize Nix store
	nix.settings.auto-optimise-store = true;

	# Enable binary caches
	nix.settings = {
		substituters = [
			"https://nix-community.cachix.org"
			"https://hyprland.cachix.org"
		];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		];
	};

	# Enable Gamemode
	programs.gamemode.enable = true;

	# Enable Gamescope
	programs.gamescope = {
		enable = true;
		capSysNice = true;
	};

	# Enable Tailscale
	services.tailscale.enable = true;

	# Leave this option alone
	system.stateVersion = "23.11"; 

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

	# Enable Hyprland
	modules.hyprland.enable = true;

	# Enable bt-sync
	modules.bluetooth.bt-sync.windows_partition = "nvme0n1p3";
}
