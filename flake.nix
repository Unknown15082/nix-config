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
		};
	};

	outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... } @ inputs : let
		inherit (self) outputs;
	in {
		nixosModules = import ./modules/nixos;
		hmModules = import ./modules/hm;
		devices = import ./modules/devices;

		nixosConfigurations.fafnir = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = {
				inherit inputs outputs;

				pkgs = import nixpkgs {
					inherit system;
					config.allowUnfree = true;

					# Explicitly allow Logseq's version of EOL Electron
					config.permittedInsecurePackages = [
						"electron-27.3.11"
					];
				};

				pkgs-stable = import nixpkgs-stable {
					inherit system;
					config.allowUnfree = true;
				};
			};
			modules = [
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
