{
	imports = [
		./shell_utils.nix
		./tmux.nix
		./hyprland.nix
	];
	
	modules.shell-utils.enable = true;
	modules.shell-utils.enableFishFunctions = true;
	modules.shell-utils.enableTmux = true;
	modules.hyprland.enable = true;
}
