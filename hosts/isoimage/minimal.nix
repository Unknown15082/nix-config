# This is intended to be a extremely minimal ISO for Digital Ocean, fitting in the 1gb RAM available.
{ pkgs, modulePath, ... }:
{
	# Setup Nix
	nixpkgs.hostPlatform = "x86_64-linux";
	nix.settings.experimental-features = [
		"nix-command" "flakes"
	];

	# Enable SSH
	services.openssh.enable = true;

	# Enable swap to evaluate nixpkgs
	swapDevices = [{
		device = "/var/lib/.swapfile";
		size = 4 * 1024; # 4GB
	}];

	system.stateVersion = "25.05";
}
