{
    lib,
    config,
    pkgs,
	nixcord,
    ...
}:
let
    cfg = config.modules.discord;
in
{
	imports = [
		nixcord.homeModules.nixcord
	];

    options.modules.discord = {
        enable = lib.mkEnableOption "Discord";
        addons = lib.mkEnableOption "Discord addons - Vesktop";
    };

    config = lib.mkIf cfg.enable {
        programs.nixcord = {
			enable = true;
			discord.enable = false;
			vesktop.enable = cfg.addons;

			discord.silenceNoModClientWarning = true;
			discord.krisp.enable = true;
		};
    };
}
