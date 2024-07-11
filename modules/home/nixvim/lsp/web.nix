{
	programs.nixvim = {
		plugins.lsp = {
			servers = {
				# Typescript
				eslint.enable = true;

				# Tailwind CSS
				tailwindcss.enable = true;
				cssls.enable = true;

				# HTML
				html.enable = true;
			};
		};

		plugins.typescript-tools.enable = true;
	};
}
