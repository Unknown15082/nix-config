{
    lib,
    libutils,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.rofi;
in
{
    options.modules.rofi = {
        enable = lib.mkEnableOption "Rofi (Wayland)";
    };

    config = lib.mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            package = pkgs.rofi;

            terminal = "${pkgs.alacritty}/bin/alacritty";

            theme = libutils.relativeToRoot "configs/rofi/launcher.rasi";
        };
    };
}
