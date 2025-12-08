{
	inputs,
	lib,
	system,
	utils,
	myvars,
	genSpecialArgs,
	...
} @ args:
let
	inherit (utils) relativeToRoot;
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
	nixosConfigurations = utils.nixosSystem (args // {
		inherit nixos-modules home-modules;
	});
}
