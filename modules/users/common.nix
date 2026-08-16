{ inputs, ... }: {
	flake.modules.nixos.userSettings = { lib, ... }: {
		options.settings = {
			userGroups = with lib; mkOption {
				type = types.listOf types.str;
				description = "List of extra groups the user belongs to";
			};
		};
	};

	flake.modules.nixos.homeManagerUser = {
		imports = [
			inputs.home-manager.nixosModules.home-manager
		];

		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.backupFileExtension = "hm.backup";
	};
}
