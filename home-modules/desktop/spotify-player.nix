{
    lib,
    config,
    secrets,
    username,
    ...
}:
let
    cfg = config.modules.spotify-player;
in
{
    options.modules.spotify-player = {
        enable = lib.mkEnableOption "spotify-player";
    };

    config = lib.mkIf cfg.enable {
        age.secrets.spotify_client_id = {
            file = "${secrets}/spotify.age";
            mode = "400";
        };

        # Thanks aome for creating spotify-player
        programs.spotify-player = {
            enable = true;
            settings = {
                client_id_command = "cat ${config.age.secrets.spotify_client_id.path}";
            };
        };
    };
}
