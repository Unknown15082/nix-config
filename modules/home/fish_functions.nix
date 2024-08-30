{ lib, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	config = lib.mkIf cfg.enableFishFunctions {
		programs.fish.functions = {
			nx = {
				description = "Runs an app from the nixpkgs store";
				wraps = "nix run";
				body = ''
					set impure
					set help_message "nx [--impure] {package} [args...]"

					if test (count $argv) = 0
						echo $help_message
						return 1
					end

					if test $argv[1] = --impure
						set impure --impure
						set argv $argv[2..]
					end

					if test (count $argv) -gt 0
						nix run $impure nixpkgs#$argv[1] -- $argv[2..]
					else
						echo $help_message
						return 1
					end
				'';
			};
		};
	};
}
