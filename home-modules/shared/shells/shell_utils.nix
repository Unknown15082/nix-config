{ lib, libutils, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	options.modules.shell-utils = {
		# TODO: Rewrite entire module with an options.nix and config-only files
		enable = lib.mkEnableOption "all shell libutils";
	};

	config = lib.mkIf cfg.enable {
		home.packages = [ pkgs.grc ];

		programs = {
			fish = {
				enable = true;
				interactiveShellInit = ''
					set fish_gretting
					_pure_prompt_new_line
				'';

				plugins = with pkgs.fishPlugins; [
					{ name = "grc"; src = grc.src; }
					{ name = "pure"; src = pure.src; }
					{ name = "fzf.fish"; src = fzf-fish.src; }
				];
			};

			fzf = {
				enable = true;
			};

			eza = {
				enable = true;
				enableFishIntegration = true;
			};

			zoxide = {
				enable = true;
				enableFishIntegration = true;

				options = [ "--cmd cd" ];
			};

			direnv = {
				enable = true;
				nix-direnv.enable = true;
				silent = true;
			};
		};

		catppuccin = {
			fish = {
				enable = true;
				flavor = "mocha";
			};
		};
	};
}
