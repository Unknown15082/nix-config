{ lib, config, ... }:
let
    cfg = config.modules.gnome;
in
{
    options.modules.gnome = {
        enable = lib.mkEnableOption "GNOME";
    };

    config = lib.mkIf cfg.enable {
        # Enable X11
        services.xserver.enable = true;

        # Enable GNOME
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;
    };
}
