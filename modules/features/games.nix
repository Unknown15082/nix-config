{ inputs, ... }: {
	flake.modules.nixos.games-steam = {
		programs.steam = {
			enable = true;
			protontricks.enable = true;

			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
		};
	};

	flake.modules.nixos.games-osu = { pkgs, ... }: {
		environment.systemPackages = [ pkgs.osu-lazer-tachyon-bin ];
	};

	flake.modules.nixos.games-ffxiv = { pkgs, ... }: {
		environment.systemPackages = [ pkgs.xivlauncher ];
	};

	flake.modules.nixos.games-gamemode = { lib, pkgs, ... }: let
		notify-send = lib.getExe pkgs.libnotify;
	in {
		programs.gamemode = {
			enable = true;
			enableRenice = true;

			settings = {
				custom = {
					start = "${notify-send} 'GameMode started'";
					end = "${notify-send} 'GameMode ended'";
				};
			};
		};
	};

	flake.modules.nixos.games-nix-gaming = {
		nixpkgs.overlays = [ inputs.nix-gaming.overlays.default ];

		settings.binaryCaches.caches = [
			{
				url = "https://nix-gaming.cachix.org";
				key = "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=";
			}
		];
	};

	flake.modules.nixos.games-ntsync = { pkgs, ... }: {
		imports = [
			inputs.nix-gaming.nixosModules.wine
		];

		nixpkgs.overlays = [
			inputs.nix-gaming.overlays.default
		];

		programs.wine = {
			enable = true;
			package = pkgs.wine-discord-ipc-bridge;
			ntsync = true;
		};
	};
}
