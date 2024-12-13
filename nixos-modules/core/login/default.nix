{ mylib, ... }:
{
	imports = mylib.scanPaths ./.;

	modules.gdm.enable = true;
}
