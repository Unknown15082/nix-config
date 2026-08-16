{ ... }: {
	flake.modules.homeManager.modernUnix = { pkgs, ... }: {
		home.packages = with pkgs; [
			fastfetch
			btop-rocm
			dust
			duf
			ripgrep
			fd
			lazygit
			unzip
			bat
			imv
			tealdeer
			yazi
		];

		programs.git.enable = true;

		programs.fzf.enable = true;

		programs.eza = {
			enable = true;
			enableFishIntegration = true;
		};

		programs.zoxide = {
			enable = true;
			enableFishIntegration = true;

			options = [ "--cmd cd" ];
		};
	};

	flake.modules.homeManager.nixtools = {
		programs.direnv = {
			enable = true;
			silent = true;
			nix-direnv.enable = true;
		};
	};
}
