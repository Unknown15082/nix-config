{
	description = "NixOS configuration flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim-config = {
			url = "github:Unknown15082/nixvim-config";
		};

		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland = {
			url = "github:hyprwm/Hyprland";
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
				inherit inputs outputs system;
			};
			modules = [
				# Make pkgs.stable available in configuration.nix and other files
				{
					nixpkgs = {
						overlays = [ overlay-stable ]; 
						config.allowUnfree = true;
					};
				}

				./modules/customs
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
