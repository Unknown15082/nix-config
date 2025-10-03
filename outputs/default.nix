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

	allHostValues = builtins.attrValues hosts;
	allOutputNames = map builtins.attrNames allHostValues;
	combinedOutputNames = lib.uniqueStrings (lib.flatten allOutputNames);

	loadOutputs = outputName: {
		${outputName} = lib.mapAttrs (
			_: out: (out.${outputName} or {})
		) hosts;
	};
in
(lib.mergeAttrsList (map loadOutputs combinedOutputNames))
// {
	# Add extra general outputs here
	# For examples, formatters
}
