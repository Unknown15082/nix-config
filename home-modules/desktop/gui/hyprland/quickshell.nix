{ lib, config, pkgs, repoRoot, ... }:
let
	cfg = config.modules.quickshell;
in
{
	options.modules.quickshell = {
		enable = lib.mkEnableOption "Quickshell";
	};

	config = lib.mkIf cfg.enable {
		home.packages = [ pkgs.quickshell ];

		xdg.configFile."quickshell" = {
			recursive = true;
			source = config.lib.file.mkOutOfStoreSymlink (repoRoot + "/configs/quickshell");
		};
	};
}
