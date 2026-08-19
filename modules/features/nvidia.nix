{ self, ... }: {
	flake.modules.nixos.nvidia = { ... }: {
		home-manager.sharedModules = [
			self.modules.homeManager.nvidiaStatus
			{ settings.nvidia.isEnabled = true; }
		];

		hardware.graphics.enable = true;

		services.xserver.videoDrivers = [
			"nvidia"
		];

		hardware.nvidia = {
			branch = "stable";
			
			modesetting.enable = true;
			open = true;
			powerManagement = {
				enable = true;
				finegrained = true;
			};
			nvidiaSettings = true;
		};
	};

	flake.modules.nixos.nvidiaOffload = {
		hardware.nvidia.prime.offload = {
			enable = true;
			enableOffloadCmd = true;
			offloadCmdMainProgram = "offload";
			kernelSuspendNotifier = true;
		};
	};

	flake.modules.homeManager.nvidiaStatus = { lib, ... }: {
		options.settings.nvidia = {
			isEnabled = with lib; mkOption {
				type = types.bool;
				default = false;
				description = "Whether Nvidia module is enabled";
			};
		};
	};
}
