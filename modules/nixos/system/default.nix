{ lib, ... }:
{
	imports = [
		./bluetooth.nix
		./sound.nix
		./nvidia.nix
		./nh.nix
		./input_method.nix
		./gnome.nix
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

	modules.nh.enable = lib.mkDefault true;

	modules.input-method.vietnamese.enable = lib.mkDefault true;

	modules.gnome.enable = false;
}
