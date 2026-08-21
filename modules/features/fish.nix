{ self, ... }: {
	flake.modules.nixos.fish = { pkgs, ... }: {
		programs.fish.enable = true;
		users.defaultUserShell = pkgs.fish;

		home-manager.sharedModules = [
			self.modules.homeManager.fish
		];
	};

	flake.modules.homeManager.fish = { pkgs, ... }: {
		imports = [
			self.modules.homeManager.fishFunctions
		];

		programs.fish = {
			enable = true;
			interactiveShellInit = ''
				set fish_greeting
				_pure_prompt_new_line
			'';

			plugins = with pkgs.fishPlugins; [
				{
					name = "grc";
					src = grc.src;
				}
				{
					name = "pure";
					src = pure.src;
				}
				{
					name = "fzf.fish";
					src = fzf-fish.src;
				}
			];
		};

		home.packages = [ pkgs.grc ];

		catppuccin.fish.enable = true;
	};

	flake.modules.homeManager.fishFunctions = {
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

					if test $argv[1] == --impure
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
