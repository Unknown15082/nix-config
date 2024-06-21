{
	description = "NixOS configuration flake";

	nixConfig = {
		substituters = [
			"https://cache.nixos.org"
			"https://nix-community.cachix.org"
			"https://ezkea.cachix.org"
		];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			"ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
		];
	};

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ...}@inputs : let
		inherit (self) outputs;
	in {
		nixosModules = import ./modules/nixos;

		nixosConfigurations.fafnir = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs outputs; };
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
