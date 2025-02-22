{ lib, ... }:
{
	imports = [
		./keyd.nix
		./qmk.nix
	];

	modules.keyd.enable = lib.mkDefault true;

	modules.qmk.enable = lib.mkDefault true;
}
