{
	inputs,
	system,
	genSpecialArgs,
	specialArgs ? (genSpecialArgs system),
	home-modules,
	...
}:
let
	inherit (inputs) nixpkgs home-manager;
	pkgs = nixpkgs.legacyPackages.${system};
in
	home-manager.lib.homeManagerConfiguration {
		inherit pkgs;
		extraSpecialArgs = specialArgs;
		modules = home-modules;
	}
