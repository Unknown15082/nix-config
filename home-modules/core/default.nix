{ mylib, ... }:
{
	imports = mylib.scanPaths ./.;
}