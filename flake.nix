{
	description = "NixOS configuration flake";

	nixConfig = {
		extra-substituters = [
			"https://nix-community.cachix.org"
		];
		extra-trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
	};

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";

			inputs.nixpkgs.follows = "nixpkgs";
			inputs.home-manager.follows = "home-manager";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... } @ inputs : let
		inherit (self) outputs;

		system = "x86_64-linux";
		overlay-stable = final: prev: {
			stable = import nixpkgs-stable {
				inherit system;
				config.allowUnfree = true;
			};
		};
	in {
		nixosConfigurations.fafnir = nixpkgs.lib.nixosSystem rec {
			inherit system;
			specialArgs = {
				inherit inputs outputs;
			};
			modules = [
				# Make pkgs.stable available in configuration.nix and other files
				({
					nixpkgs = {
						overlays = [ overlay-stable ]; 
						config.allowUnfree = true;
					};
				})

				./modules/nixos
				./modules/devices
				./hosts/fafnir/configuration.nix

				# Allow the following users to add binary cache servers:
				{
					nix.settings.trusted-users = [ "unknown" ];
				}

				# Home-manager
				home-manager.nixosModules.home-manager

				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = specialArgs;

					home-manager.users.unknown = import ./home/unknown.nix;
				}
			];
		};
	};
}
