{
	inputs,
	lib,
	system,
	mylib,
	myvars,
	genSpecialArgs,
	...
} @ args:
let
	inherit (mylib) relativeToRoot;
	name = "fafnir";

	nixos-modules = map relativeToRoot [
		"nixos-modules"
		"hosts/${name}/configuration.nix"
	];

	home-modules = map relativeToRoot [
		"home-modules"
		"hosts/${name}/home.nix"
	];
in
{
	nixosConfigurations = mylib.nixosSystem (args // {
		inherit nixos-modules home-modules;
	});
}
