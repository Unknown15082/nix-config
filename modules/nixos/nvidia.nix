{ config, ... }:
{
	# Enable OpenGL
	hardware.opengl.enable = true;

	# Load nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = [ "nvidia" ];

	# Nvidia
	hardware.nvidia = {
		# Choose the Nvidia driver version

		package = config.boot.kernelPackages.nvidiaPackages.beta; # Nvidia driver 555
	
		# Enable modesetting
		modesetting.enable = true;

		# Disable the open source kernel module (not nouveau)
		# This is alpha-quality/buggy
		open = false;

		# Enable the Nvidia settings menu with nvidia-settings
		nvidiaSettings = true;

		# Enable PRIME offload
		prime.offload = {
			enable = true;
			enableOffloadCmd = true;
		};
	};
}
