{
	imports = [
		./shell_utils.nix
	];
	
	modules.shell-utils.enable = true;
	modules.shell-utils.enableFishFunctions = true;
}
