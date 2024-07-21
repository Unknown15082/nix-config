{
	programs.nixvim = {
		plugins = {
			lsp.servers = {
				clangd.enable = true;
			};

			clangd-extensions.enable = true;
		};
	};
}
