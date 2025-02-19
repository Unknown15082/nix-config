{ pkgs, lib, ... }:
{
	imports = [
		./disks.nix
		./hardware-configuration.nix
	];

	# Disko
	disko.devices.disk.main.device = "/dev/vda";

	# Network setup for DigitalOcean
	networking.useDHCP = lib.mkForce false;
	services.cloud-init = {
		enable = true;
		network.enable = true;
		settings = {
			datasource_list = [ "ConfigDrive" ];
			datasource.ConfigDrive = {};
		};
	};

	boot.loader.grub = {
		efiSupport = true;
		efiInstallAsRemovable = true;
	};

	services.openssh.enable = true;

	environment.systemPackages = with pkgs; [
		neovim
		git

		dive
		podman-tui
		podman-compose
	];

	virtualisation.containers.enable = true;
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
		defaultNetwork.settings.dns_enabled = true;
	};

	system.stateVersion = "25.05";
}
