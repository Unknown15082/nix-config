# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
{
	imports =
		[ (modulesPath + "/installer/scan/not-detected.nix")
		];

	# List of kernel modules

	boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ ];
	boot.supportedFilesystems = [ "btrfs" "ntfs" ];

	# Declare the filesystem

	fileSystems."/" =
	{ 	device = "/dev/disk/by-uuid/b5c0a56f-f40f-41d5-8168-994c6ebcb428";
		fsType = "btrfs";
		options = [ "subvol=@" ];
	};

	fileSystems."/boot" =
	{ 	device = "/dev/disk/by-uuid/68E6-4D5A";
		fsType = "vfat";
		options = [ "fmask=0022" "dmask=0022" ];
	};

	# Add a 8GB swapfile

	swapDevices = [ {
		device = "/swapfile";
		size = 8 * 1024; # 8GB
	} ];

	# Other hardware values

	networking.useDHCP = lib.mkDefault true;
	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

	# Enable microcode update

	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


	# The PCI IDs of the GPUs, in order to effectively offload the dGPU
	hardware.nvidia.prime = {
		amdgpuBusId = "PCI:5:0:0";
		nvidiaBusId = "PCI:1:0:0";
	};

	# Define the hostname
	networking.hostName = "fafnir";

	# Mount additional partitions
	fileSystems."/mnt/osu" = {
		device = "/dev/disk/by-uuid/5CAC7A9EAC7A727E";
		fsType = "ntfs-3g";
		options = [ "rw" ];
	};
}
