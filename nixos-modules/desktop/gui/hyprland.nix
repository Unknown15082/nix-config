{
    inputs,
    lib,
    config,
    system,
    pkgs,
    ...
}:
let
    cfg = config.modules.hyprland;
in
{
    options.modules.hyprland = {
        enable = lib.mkEnableOption "Hyprland";
    };

    config = lib.mkIf cfg.enable {
        programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages."${system}".hyprland;
            portalPackage = inputs.hyprland.packages."${system}".xdg-desktop-portal-hyprland;
            # withUWSM = true;
        };

        xdg.portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };

        security.polkit.enable = true;
        security.pam.services.hyprlock = { };

        environment.systemPackages = with pkgs; [
            hyprpolkitagent
        ];

        # Enable hyprland's binary cache
        modules.binary-caches = [
            {
                url = "https://hyprland.cachix.org";
                key = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
                priority = 10;
            }
        ];

        hm.modules.hyprland.enable = true;
    };
}
