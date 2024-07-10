{
	imports = [
		./bluetooth.nix
		./sound.nix
	];

	modules.bluetooth.enable = true;
	
	modules.sound.enable = true;
	modules.sound.low-latency.enable = true;
}
