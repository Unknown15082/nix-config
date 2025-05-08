{ lib, mylib, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	options.modules.shell-utils = {
		enable = mylib.mkEnableTrueOption "all shell utils";
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
				];
			};

			fzf = {
				enable = true;
				enableFishIntegration = true;
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
