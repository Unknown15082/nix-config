{ inputs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
	] ++ [
		# Add config files here
		./colorscheme.nix
	];

	programs.nixvim = {
		enable = true;
		defaultEditor = true;
		vimdiffAlias = true;
	};
}
