{ inputs, self, ... }: {
	flake.modules.homeManager.neovimGeneralSettings = {
		home.sessionVariables = {
			EDITOR = "nvim";
		};
	};

	flake.modules.homeManager.nixvim = { pkgs, ... }: {
		imports = [
			self.modules.homeManager.neovimGeneralSettings
		];

		home.packages = [
			inputs.nixvim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	};
}
