{ lib, config, ... }:
let
	cfg = config.modules.games;
in {
	options.modules.games = {
		enableBinaryCache = lib.mkEnableOption "nix-gaming binary cache";
	};

	config = lib.mkIf cfg.enableBinaryCache {
		nix.settings = {
			substituters = [ "https://nix-gaming.cachix.org" ];
			trusted-public-keys = [
				"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
			];
		};
	};
}
