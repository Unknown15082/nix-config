{
	imports = [
		./shell_utils.nix
		./tmux.nix
	];
	
	modules.shell-utils.enable = true;
	modules.shell-utils.enableFishFunctions = true;
	modules.shell-utils.enableTmux = true;
}
