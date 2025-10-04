{
	nixpkgs,
	...
} @ inputs:
let
	inherit (nixpkgs) lib;

	mylib = import ../lib { inherit lib; };
	myvars = import ../vars;

	genSpecialArgs = system:
		inputs // {
			inherit mylib myvars;
			inherit system;
		};

	mkArgs = system: {
		inherit inputs lib system mylib myvars genSpecialArgs;
	};

	# To add a new machine, import it here
	hosts = {
		fafnir = import ./src/fafnir.nix (mkArgs "x86_64-linux");
	};
	allSystems = [ "x86_64-linux" ];

	loadOutputs = name:
		hosts
		|> lib.filterAttrs (_: lib.hasAttr name)
		|> lib.mapAttrs (_: v: v.${name});

	allHostValues = builtins.attrValues hosts;
	allOutputNames =
		allHostValues
		|> map builtins.attrNames
		|> lib.flatten
		|> lib.uniqueStrings;

	forAllSystems = lib.genAttrs allSystems;
in
(lib.genAttrs allOutputNames loadOutputs)
// {
	formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
}
