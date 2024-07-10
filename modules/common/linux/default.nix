{ lib, ... }:
{
	imports = [
		./bluetooth.nix
		./sound.nix
		./nvidia.nix
		./systemd-boot.nix
	];

	modules.bluetooth.enable = lib.mkDefault true;
	
	modules.sound = {
		enable = lib.mkDefault true;
		low-latency.enable = lib.mkDefault true;
	};

	modules.nvidia = {
		enable = lib.mkDefault true;
		beta = lib.mkDefault true;
		offload = lib.mkDefault true;
		sync = lib.mkDefault false;
	};

	modules.systemd-boot = {
		enable = lib.mkDefault true;
	};
}
