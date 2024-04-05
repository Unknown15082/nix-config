{ config, pkgs, ... }:

{
	# Hostname
	networking.hostName = "fafnir";

	# Enable Flakes
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		auto-optimise-store = true;
	};

	# Bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Networking
	networking.networkmanager.enable = true;

	# Timezone + Locale
	time.timeZone = "Asia/Ho_Chi_Minh";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_TIME = "en_DK.UTF-8";
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# State version
	system.stateVersion = "23.05";
}
