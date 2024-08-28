{ pkgs, ... }:
{
	programs.nixvim.plugins = {
		vimtex = {
			enable = true;
			settings = {
				view_method = "zathura";

				compiler_latexmk = {
					aux_dir = "aux/";
					out_dir = "dir/";
				};
			};
		};
	};
}
