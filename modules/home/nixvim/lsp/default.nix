{
	imports = [
		./web.nix
		./rust.nix
	];

	programs.nixvim = {
		plugins.lsp.enable = true;
		plugins.lsp-format.enable = true;
	};
}
