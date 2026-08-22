{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.playerctl;
in
{
    options.modules.playerctl = {
        enable = lib.mkEnableOption "playerctl";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.playerctl ];

        services.playerctld.enable = true;
    };
}
