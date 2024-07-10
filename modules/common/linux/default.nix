{ lib, ... }:
{
	imports = [
		./bluetooth.nix
		./sound.nix
		./nvidia.nix
	];

	modules.bluetooth.enable = lib.mkDefault true;
	
	modules.sound.enable = lib.mkDefault true;
	modules.sound.low-latency.enable = lib.mkDefault true;

	modules.nvidia.enable = lib.mkDefault true;
	modules.nvidia.beta = lib.mkDefault true;
	modules.nvidia.offload = lib.mkDefault true;
	modules.nvidia.sync = lib.mkDefault false;
}
