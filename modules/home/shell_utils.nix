{ lib, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	options.modules.shell-utils = {
		enable = lib.mkEnableOption "all shell utils";
	};

	config = lib.mkIf cfg.enable {
		programs = {
			fish = {
				enable = true;
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

			starship = {
				enable = true;
				enableFishIntegration = true;
				settings = {
					add_newline = true;

					format = lib.concatStrings [
						"$directory \n"
						"[└─> ](bold green)"
					];
				};
			};
		};
	};
}
