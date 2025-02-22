{ lib, config, osConfig, ... }:
let
	cfg = config.modules.games;
in {
	options.modules.games = {
		enableBinaryCache = lib.mkEnableOption "nix-gaming binary cache";
	};

	config = lib.mkIf cfg.enableBinaryCache {
		# TODO: Temporary fix, move to global home-manager config later
		nix.settings = {
			substituters = [ "https://nix-gaming.cachix.org" ] ++ osConfig.nix.settings.substituters;
			trusted-public-keys = [
				"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
			] ++ osConfig.nix.settings.trusted-public-keys;
		};
	};
}
