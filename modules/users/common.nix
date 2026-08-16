{ inputs, ... }: {
	flake.modules.nixos.userSettings = { lib, config, ... }: let
		normalUsers = lib.filterAttrs (_: u: u.isNormalUser) config.users.users;
		userList = lib.attrValues normalUsers;
	in {
		options.settings = {
			userGroups = with lib; mkOption {
				type = types.listOf types.str;
				description = "List of extra groups the user belongs to";
			};

			primaryUser = with lib; mkOption {
				type = types.str;
				readOnly = true;
				default = if userList == [] then "root" else (head userList).name;
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
