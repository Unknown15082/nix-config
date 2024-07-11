{ lib, config, inputs, ... }:
let
	cfg = config.modules.nixvim;
in
{
	options.modules.nixvim = {
		enable = lib.mkEnableOption "NixVim";
	};

	imports = [
		inputs.nixvim.homeManagerModules.nixvim

		./colorscheme.nix
		./options.nix
		./lsp
	];

	config = lib.mkIf cfg.enable {
		programs.nixvim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			vimdiffAlias = true;

			enableMan = true;
		};
	};
}
