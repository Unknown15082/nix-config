{ self, inputs, ... }: {
	flake.modules.nixos.bahamutHardware = { config, ... }: {
		boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
		boot.initrd.kernelModules = [];
		boot.kernelModules = [ "kvm-intel" ];
		boot.extraModulePackages = [];

		nixpkgs.hostPlatform = "x86_64-linux";
		hardware.enableRedistributableFirmware = true;
		hardware.cpu.intel.npu.enable = true;
		hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

		fileSystems."/" = {
			device = "/dev/disk/by-label/NIXOS";
			fsType = "btrfs";
			options = [ "subvol=root" "compress=zstd" "space_cache=v2" "ssd" ];
		};

		fileSystems."/home" = {
			device = "/dev/disk/by-label/NIXOS";
			fsType = "btrfs";
			options = [ "subvol=home" "compress=zstd" "space_cache=v2" "ssd" ];
		};

		fileSystems."/nix" = {
			device = "/dev/disk/by-label/NIXOS";
			fsType = "btrfs";
			options = [ "subvol=home" "compress=zstd" "noatime" "space_cache=v2" "ssd" ];
		};

		fileSystems."/boot" = {
			device = "/dev/disk/by-label/NIXBOOT";
			fsType = "vfat";
			options = [ "fmask=0022" "dmask=0022" ];
		};

		swapDevices = [];
	};

	flake.modules.nixos.bahamut = { ... }: {
		imports = with self.modules.nixos; [
			bahamutHardware
			presets-desktop
			user-unknown
		];

		networking.hostName = "bahamut";
		system.stateVersion = "26.05";
	};

	flake.nixosConfigurations.bahamut = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			self.modules.nixos.bahamut
		];
	};
}
