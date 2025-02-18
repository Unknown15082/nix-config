{
	inputs,
	lib,
	system,
	nixos-modules,
	home-modules ? [],
	specialArgs,
	username,
	...
}: let
	inherit (inputs) nixpkgs home-manager;
	fullSpecialArgs = specialArgs // {
		inherit inputs system username;
	};
in
	nixpkgs.lib.nixosSystem {
		inherit system;
		specialArgs = fullSpecialArgs;

		modules =
			nixos-modules
			++ (
				lib.optionals
				((lib.lists.length home-modules) > 0)
				[
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.extraSpecialArgs = fullSpecialArgs;

						home-manager.users."${username}".imports = home-modules;
					}
				]
			);
	}
