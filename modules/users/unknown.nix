{ self, ... }: {
	flake.modules.nixos.users.unknown = { config, ... }: {
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
		};

		home-manager.users.unknown.imports = [
			self.modules.homeManager.users.unknown
		];
	};

	flake.modules.homeManager.users.unknown = {};
}
