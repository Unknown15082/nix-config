{ lib, mylib, ... }:
{
	imports = mylib.scanPaths ./.;

	modules.sddm.enable = lib.mkDefault true;
}
