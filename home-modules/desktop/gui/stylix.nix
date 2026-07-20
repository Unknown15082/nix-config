{ lib, config, ... }:
let
    cfg = config.modules.stylix;
in
{
    options.modules.stylix = {
        enable = lib.mkEnableOption "Stylix";
    };

    config = lib.mkIf cfg.enable {
        stylix.targets = {
            fish.enable = false;
            rofi.enable = false;
            gnome-text-editor.enable = false;
			hyprland.enable = false;
			hyprpaper.enable = false;
        };
    };
}
