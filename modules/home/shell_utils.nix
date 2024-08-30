{
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
	};
}
