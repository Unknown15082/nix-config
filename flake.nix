{
	description = "NixOS configuration flake";

	nixConfig = {
		extra-substituters = [
			"https://nix-community.cachix.org"
			"https://ezkea.cachix.org"
		];
		extra-trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			"ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
		];
	};

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, ... } @ inputs : let
		inherit (self) outputs;
	in {
		nixosModules = import ./modules/nixos;

		nixosConfigurations.fafnir = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = {
				inherit inputs outputs;

				pkgs-unstable = import nixpkgs-unstable {
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
			];
		};
	};
}
