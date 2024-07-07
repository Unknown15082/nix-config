{ inputs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
	] ++ [
		# Add config files here
		./colorscheme.nix
		./options.nix
		./lsp
	];

	programs.nixvim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;

		enableMan = true;
	};
}
