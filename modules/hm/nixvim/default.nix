{ inputs, ... }:
{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim
	] ++ [
		# Add config files here
	];

	programs.nixvim = {
		enable = true;
		defaultEditor = true;
		vimdiffAlias = true;
	};
}
