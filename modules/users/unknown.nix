{ self, ... }: {
	flake.modules.nixos.user-unknown = { config, ... }: {
		imports = [
			self.modules.nixos.userSettings
			self.modules.nixos.homeManagerUser
		];

		settings.userGroups = [ "wheel" ];

		users.users.unknown = {
			isNormalUser = true;
			createHome = true;
			uid = 1000;

			extraGroups = config.settings.userGroups;
			initialHashedPassword = "";
		};

		home-manager.users.unknown.imports = [
			self.modules.homeManager.user-unknown
		];
	};

	flake.modules.homeManager.user-unknown = {
		home.username = "unknown";
		home.homeDirectory = "/home/unknown";

		programs.home-manager.enable = true;
	};
}
