{ lib, config, inputs, ... }:
let
	cfg = config.modules.nix-settings;
in {
	options.modules.nix-settings = {
		enable = lib.mkEnableOption "general nix settings";
	};

	config = lib.mkIf cfg.enable {
		# Set Nix PATH
		nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

		# Enable experimental features
		#	nix-command: modern Nix CLI
		#	flakes: flake system
		#	pipe-operators: |>
		nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

		# Allow unfree packages
		nixpkgs.config.allowUnfree = true;

		# Auto-optimize Nix store
		nix.settings.auto-optimise-store = true;

		# Save outputs and derivations for nix-direnv
		nix.extraOptions = ''
			keep-outputs = true
			keep-derivations = true
		'';

		# Enable nix-ld
		programs.nix-ld.enable = true;

		# nix-community binary cache
		nix.settings = {
			substituters = [ "https://nix-community.cachix.org" ];
			trusted-public-keys = [
				"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			];
		};

		# Trust all users in @wheel
		nix.settings.trusted-users = [ "@wheel" ];
	};
}
