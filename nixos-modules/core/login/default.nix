{ lib, mylib, ... }:
{
	imports = mylib.scanPaths ./.;

	# TODO: Move these to desktop/
	modules.sddm.enable = lib.mkDefault true;
}
