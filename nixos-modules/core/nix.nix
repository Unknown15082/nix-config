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

		# Enable flakes and the new Nix CLI
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		# Auto-optimize Nix store
		nix.settings.auto-optimise-store = true;

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
