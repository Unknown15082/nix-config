{ ... }: {
	flake.modules.nixos.nvidia = { config, ... }: {
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
}
