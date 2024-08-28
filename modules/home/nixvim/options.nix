{ pkgs, ... }:
{
	programs.nixvim = {
		editorconfig.enable = true;
		clipboard.register = "unnamedplus";
		clipboard.providers.wl-copy.enable = true;

		globals = {
			maplocalleader = " ";
		};

		opts = {
			# General
			mouse = "a";
			swapfile = false;
			undofile = true;
			termguicolors = true;
		
			# UI
			shortmess = "ltToOCFsI";
			cursorline = true;
			signcolumn = "yes";
			showmode = false;

			# UX
			number = true;
			relativenumber = true;
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
