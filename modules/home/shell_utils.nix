{ lib, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	options.modules.shell-utils = {
		enable = lib.mkEnableOption "all shell utils";
		enableFishFunctions = lib.mkEnableOption "fish functions";
		enableTmux = lib.mkEnableOption "tmux";
	};

	imports = [
		./fish_functions.nix
		./tmux.nix
	];

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

			eza = {
				enable = true;
				enableBashIntegration = true;
			};

			zoxide = {
				enable = true;
				enableBashIntegration = true;

				options = [ "--cmd cd" ];
			};

			direnv = {
				enable = true;
				nix-direnv.enable = true;
				silent = true;
			};
		};
	};
}
