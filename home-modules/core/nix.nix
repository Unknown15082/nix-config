{ lib, osConfig, ... }:
{
	nixpkgs = {
		config = lib.mapAttrs (n: v: lib.mkDefault v) osConfig.nixpkgs.config;
		overlays = lib.mkOrder 990 osConfig.nixpkgs.overlays;
	};
}
