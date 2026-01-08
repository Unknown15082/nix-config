{
	inputs,
	libutils,
	...
} @ args:
let
	inherit (libutils) relativeToRoot;
	name = "fafnir";

	nixos-modules = map relativeToRoot [
		"nixos-modules"
		"secrets"
		"hosts/${name}/configuration.nix"
	] ++ [
		inputs.catppuccin.nixosModules.catppuccin # TODO: Move to separate module
	];

	home-modules = map relativeToRoot [
		"home-modules"
		"hosts/${name}/home.nix"
	] ++ [
		inputs.catppuccin.homeModules.catppuccin # TODO: Move to separate module
	];
in
{
	nixosConfigurations = libutils.nixosSystem (args // {
		inherit nixos-modules home-modules;
	});
}
