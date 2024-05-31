{
	description = "NixOS configuration flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
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
			];
		};
	};
}
