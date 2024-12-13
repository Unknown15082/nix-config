{ lib, mylib, ... }:
{
	imports = mylib.scanPaths ./.;

	modules.gdm.enable = lib.mkDefault true;
}
