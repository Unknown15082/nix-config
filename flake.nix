{
    description = "NixOS configuration flake";

    inputs = {
		#--- MAIN INPUTS ---#
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-parts.url = "github:hercules-ci/flake-parts";
		import-tree.url = "github:vic/import-tree";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#--- EXTRA INPUTS ---#
		hyprland.url = "github:hyprwm/Hyprland";
		catppuccin.url = "github:catppuccin/nix";
		nixvim-config.url = "github:Unknown15082/nixvim-config";

		nix-gaming = {
			url = "github:fufexan/nix-gaming";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixcord = {
			url = "github:4evy/nixcord";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		waybar = {
			url = "github:Alexays/waybar";
			inputs.nixpkgs.follows = "nixpkgs";
		};
   };

    outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ( inputs.import-tree ./modules );
}
