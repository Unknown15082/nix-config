{ pkgs, lib, config, ... }:
let
	cfg = config.modules.games.steam;
in {
	options.modules.games.steam = {
		enable = lib.mkEnableOption "Steam";
	};

	config = lib.mkIf cfg.enable {
		programs.steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;

			gamescopeSession.enable = true;
		};

		programs.gamemode.enable = true;
		programs.gamescope = {
			enable = true;
			capSysNice = true;
		};
		environment.systemPackages = with pkgs; [ mangohud ];
	};
}
