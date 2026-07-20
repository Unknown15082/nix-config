{
    lib,
    libutils,
    config,
    osConfig,
    pkgs,
    ...
}:
let
    cfg = config.modules.hyprland;
in
{
    imports = [
        ./hyprland-settings.nix
    ];

    options.modules.hyprland = {
        enable = lib.mkEnableOption "Hyprland";
        enableNvidia = lib.mkEnableOption "Hyprland's NVIDIA settings";
    };

    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
            hyprpaper
            grimblast
        ];

        home.pointerCursor.enable = true; # fixes warning

        wayland.windowManager.hyprland = {
            enable = true;
            package = null;
            portalPackage = null;

            configType = "lua";

            systemd = {
                enable = !osConfig.programs.hyprland.withUWSM;
                variables = [ "--all" ];
            };
        };

        modules = {
            rofi.enable = true;
            waybar.enable = false;
            osd.enable = true;
            mako.enable = true;
            hyprlock.enable = true;
            hypridle.enable = true;
        };
    };
}
