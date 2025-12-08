{
	description = "NixOS configuration flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim-config = {
			url = "github:Unknown15082/nixvim-config";
		};

		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-gaming = {
			url = "github:fufexan/nix-gaming";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko/latest";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		headplane = {
			url = "github:tale/headplane?tag=v0.6.0";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:danth/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		caelestia = {
			url = "github:caelestia-dots/shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
		catppuccin.url = "github:catppuccin/nix";

		secrets = {
			url = "git+ssh://git@github.com/Unknown15082/nix-secrets.git?shallow=1";
			flake = false;
		};
	};

	# outputs = inputs: import ./outputs inputs;

	outputs = { self, nixpkgs, nixpkgs-stable, ... } @ inputs : let
		inherit (self) outputs;
		inherit (nixpkgs) lib;

		utils = import ./lib { inherit lib; };
		system = "x86_64-linux";
		username = "unknown";
		repoRoot = "/home/${username}/nix-config";

		specialArgs = {
			inherit outputs utils;
			inherit repoRoot;
		};

		# Add pkgs.stable
		overlay-stable = final: prev: {
			stable = import nixpkgs-stable {
				inherit system;
				config.allowUnfree = true;
			};
		};

		modify-pkgs = {
			nixpkgs.overlays = [ overlay-stable ];
			nixpkgs.config.allowUnfree = true;
		};
	in {
		nixosConfigurations.fafnir = utils.nixosSystem {
			inherit inputs lib system specialArgs username;

			nixos-modules = [
				modify-pkgs
				inputs.catppuccin.nixosModules.catppuccin # Put this in core/colors.nix
				inputs.stylix.nixosModules.stylix # Move to stylix.nix
				inputs.nix-index-database.nixosModules.nix-index # Move to nix.nix
			]
			++ builtins.map utils.relativeToRoot [
				"nixos-modules"
				"secrets"
				"hosts/fafnir/configuration.nix"
			];

			home-modules = [
				inputs.catppuccin.homeModules.catppuccin # Move in hm's core/colors.nix
				inputs.caelestia.homeManagerModules.default # Remove
				inputs.agenix.homeManagerModules.default # Move to hm's secrets
			]
			++ builtins.map utils.relativeToRoot [
				"home-modules"
				"hosts/fafnir/home.nix"
			];
		};

		nixosConfigurations.customISO = utils.nixosSystem {
			inherit inputs lib system specialArgs;
			username = "nixos";

			nixos-modules = [
				modify-pkgs
			] ++ builtins.map utils.relativeToRoot [
				"nixos-modules/core/bluetooth.nix"
				"nixos-modules/programs/automatic-timezoned.nix"
				"hosts/isoimage/configuration.nix"
			];

			home-modules = [
				inputs.catppuccin.homeModules.catppuccin
			] ++ builtins.map utils.relativeToRoot [
				"home-modules/core/shells"
				"hosts/isoimage/home.nix"
			];
		};

		nixosConfigurations.ifrit = utils.nixosSystem {
			inherit inputs lib system specialArgs username;

			nixos-modules = [
				modify-pkgs
			] ++ builtins.map utils.relativeToRoot [
				"secrets"
				"hosts/ifrit/configuration.nix"
				"nixos-modules/programs/selfhost"
			];
		};

		nixosConfigurations.scylla = utils.nixosSystem {
			inherit inputs lib system specialArgs username;

			nixos-modules = [
				modify-pkgs
				inputs.disko.nixosModules.disko
			] ++ builtins.map utils.relativeToRoot [
				"secrets"
				"hosts/scylla/configuration.nix"
				"nixos-modules/programs/selfhost"
			];
		};
	};
}
