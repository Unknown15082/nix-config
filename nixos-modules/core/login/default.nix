{ lib, utils, ... }:
{
	imports = utils.scanPaths ./.;

	# TODO: Move these to desktop/
	modules.sddm.enable = lib.mkDefault true;
}
