{ lib, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			fastfetch
			btop-rocm
			dust
			duf
			ripgrep
			fd
			lazygit
			unzip
			bat
			imv
			tldr
			yazi
		];
	};
}
