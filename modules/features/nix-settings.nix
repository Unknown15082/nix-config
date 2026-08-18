{ self, inputs, ... }: {
	flake.modules.nixos.nixSettings = {
		imports = [
			self.modules.nixos.binaryCaches
		];

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

		settings.binaryCaches.caches = [
            {
                url = "https://cache.nixos.org";
                key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
                priority = 2;
            }
            {
                url = "https://nix-community.cachix.org";
                key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
                priority = 5;
            }
        ];
	};

	flake.modules.nixos.binaryCaches = { config, lib, ... }: let
		cfg = config.settings.binaryCaches;
	in {
		options.settings.binaryCaches = {
			caches = with lib; mkOption {
				type = types.listOf (
					types.submodule {
						options = {
							url = mkOption {
								type = types.str;
								description = "URL of binary caches";
							};

							key = mkOption {
								type = types.str;
								description = "Public key of binary caches";
							};

							priority = mkOption {
								type = types.int;
								description = "Priority of binary cache. Lower number indicates a higher priority";
								default = 10;
							};
						};
					}
				);
			};
		};

		config = {
			nix.settings = let
				caches = map (v: "${v.url}?priority=${toString v.priority}") cfg.caches;
				keys = map (v: v.key) cfg.caches;
			in {
				substituters = lib.mkForce caches;
				trusted-substituters = lib.mkForce caches;
				trusted-public-keys = lib.mkForce keys;
			};
		};
	};

	flake.modules.homeManager.nh = { config, ... }: {
		programs.nh = {
			enable = true;

			clean = {
				enable = true;
				dates = "weekly";
				extraArgs = "--keep-since 7d --keep 3";
			};

			flake = "${config.home.homeDirectory}/nix-config/";
		};
	};
}
