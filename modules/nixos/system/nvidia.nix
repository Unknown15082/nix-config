{ lib, config, ... }:
let
	cfg = config.modules.nvidia;
in
{
	options.modules.nvidia = {
		enable = lib.mkEnableOption "Nvidia";

		beta = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable the beta Nvidia driver version";
		};

		# Offload mode and Sync mode are mutually exclusive
		offload = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "Whether to enable Offload mode";
		};

		sync = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable Sync mode";
		};
	};

	config = lib.mkIf cfg.enable {
		# Enable OpenGL
		hardware.graphics.enable = true;
	
		# Load Nvidia driver
		services.xserver.videoDrivers = [ "nvidia" ];

		hardware.nvidia = {
			# Select version
			package = with config.boot.kernelPackages.nvidiaPackages; (if cfg.beta then beta else stable);

			# Enable modesetting
			modesetting.enable = true;

			# Disable the open source kernel module (not nouveau)
			# Recommended to disable, as this is alpha-quality/buggy
			open = false;

			# Enable the Nvidia settings menu with nvidia-settings
			nvidiaSettings = true;

			# Enable PRIME offload
			prime.offload = lib.mkIf cfg.offload {
				enable = true;
				enableOffloadCmd = true;
			};

			# Enable PRIME sync
			prime.sync = lib.mkIf cfg.sync {
				enable = true;
			};
		};
	};
}
