{ inputs, ... }: {
	flake.modules.nixos.nixSettings = {
		nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

		nix.settings.experimental-features = [
			"nix-command" "flakes" "pipe-operators"
		];

		nixpkgs.config.allowUnfree = true;
		nix.settings.auto-optimise-store = true;
		nix.settings.trusted-users = [ "@wheel" ];
		nix.extraOptions = ''
			keep-outputs = true
			keep-derivations = true
		'';

		programs.nix-ld.enable = true;
	};
}
