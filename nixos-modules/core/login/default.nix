{ mylib, ... }:
{
	imports = mylib.scanPaths ./.;
}
