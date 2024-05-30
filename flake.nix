{
	description = "NixOS configuration flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ...}@inputs : {
		nixosConfigurations.fafnir = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/fafnir/configuration.nix
			];
		};
	};
}
