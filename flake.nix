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

	outputs = { self, nixpkgs, nixpkgs-stable, ... } @ inputs : let
		inherit (self) outputs;
		inherit (nixpkgs) lib;

		mylib = import ./lib { inherit lib; };
		system = "x86_64-linux";
		username = "unknown";

		specialArgs = {
			inherit inputs outputs system mylib;
			pkgs-stable = import nixpkgs-stable {
				inherit system;
				config.allowUnfree = true;
			};
		};

		# Add pkgs.stable
		overlay-stable = final: prev: {
			stable = import nixpkgs-stable {
				inherit system;
				config.allowUnfree = true;
			};
		};

		modify-pkgs = {
			nixpkgs.overlays = [ overlay-stable ];
			nixpkgs.config.allowUnfree = true;
		};
	in {
		nixosConfigurations.fafnir = mylib.nixosSystem {
			inherit inputs lib system specialArgs username;

			nixos-modules = [ modify-pkgs ] ++
				builtins.map mylib.relativeToRoot [
					"modules/nixos"
					"nixos-modules"
					"hosts/fafnir/configuration.nix"
				];

			home-modules = builtins.map mylib.relativeToRoot [
				"home-modules"
				"hosts/fafnir/home.nix"
			];
		};
	};
}
