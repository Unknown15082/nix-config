{
    lib,
    libutils,
    config,
    ...
}:
let
    cfg = config.modules.hyprpaper;
in
{
    options.modules.hyprpaper = {
        enable = lib.mkEnableOption "Hyprpaper";
    };

    config = lib.mkIf cfg.enable {
        services.hyprpaper = {
            enable = true;
            settings = {
                splash = false;
                wallpaper = [
                    {
                        monitor = "";
                        path = toString (libutils.relativeToRoot "configs/wallpaper/wallpaper.png");
                    }
                ];
            };
        };
    };
}
