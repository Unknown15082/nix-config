{
	programs = {
		eza = {
			enable = true;
			enableBashIntegration = true;
		};

		zoxide = {
			enable = true;
			enableBashIntegration = true;

			options = [ "--cmd cd" ];
		};
	};
}
