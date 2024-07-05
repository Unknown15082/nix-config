{
	programs.nixvim = {
		# Enable Catppuccin
		colorschemes.catppuccin = {
			enable = true;
			settings = {
				flavour = "mocha";

				integrations = {
					native_lsp.enabled = true;
					semantic_tokens = true;
				};

				dim_inactive.enabled = true;
			};
		};
	};
}
