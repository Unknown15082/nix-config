{ self, ... }: {
	flake.modules.nixos.docker = {
		imports = [
			self.modules.nixos.userSettings
		];

		virtualisation.docker.enable = true;
		settings.userGroups = [ "docker" ];
	};

	flake.modules.nixos.libvirtd = { pkgs, ... }: {
		imports = [
			self.modules.nixos.userSettings
		];

		virtualisation.libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu_kvm;
				runAsRoot = true;
				swtpm.enable = true;
			};
		};

		environment.systemPackages = with pkgs; [ virt-manager ];

		settings.userGroups = [ "libvirtd" ];
	};

	flake.modules.nixos.waydroid = {
		virtualisation.waydroid.enable = true;
	};
}
