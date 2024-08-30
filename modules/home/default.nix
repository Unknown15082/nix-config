{
	imports = [
		./nixvim
		./shell_utils.nix
	];

	modules.nixvim.enable = true;
	modules.shell-utils.enable = true;
}
