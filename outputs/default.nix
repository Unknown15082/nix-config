{
	self,
	nixpkgs,
	deploy-rs,
	...
} @ inputs:
let
	inherit (nixpkgs) lib;

	utils = import ../utils { inherit lib; };
	myvars = import ../vars;

	genSpecialArgs = system:
		inputs // {
			inherit utils myvars;
			inherit system;
		};

	mkArgs = system: {
		inherit inputs lib system utils myvars genSpecialArgs;
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

	forAllSystems = lib.genAttrs allSystems;
in
{
	nixosConfigurations = loadOutputs "nixosConfigurations";
	homeConfigurations = loadOutputs "homeConfigurations";
	deploy.nodes = loadOutputs "nodes";

	checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

	formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
}
