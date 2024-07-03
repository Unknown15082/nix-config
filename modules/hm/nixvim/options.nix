{
	programs.nixvim = {
		editorconfig.enable = true;
		clipboard.register = "unnamedplus";

		opts = {
			# General
			mouse = "a";
			swapfile = false;
			undofile = true;
			termguicolors = true;
		
			# UI
			cursorline = true;
			signcolumn = "yes";
			showmode = false;
			number = true;
			numberwidth = 4;
			cmdheight = 1;
			laststatus = 3;
			wrap = true;

			# Indentation
			expandtab = false;
			shiftwidth = 4;
			tabstop = 4;
			softtabstop = 4;
			smartindent = true;

			# Split
			splitbelow = true;
			splitright = true;
			splitkeep = "cursor";
		};
	};
}
