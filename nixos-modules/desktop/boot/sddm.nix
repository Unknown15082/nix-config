{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.sddm;
in
{
    options.modules.sddm = {
        enable = lib.mkEnableOption "SDDM";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [
            # (pkgs.catppuccin-sddm.override {
            #     flavor = "mocha";
            #     accent = "sapphire";
            #     font = config.stylix.fonts.sansSerif.name;
            #     fontSize = "12";
            # })
            (pkgs.sddm-astronaut.override {
                embeddedTheme = "pixel_sakura";
                themeConfig = {
                    DateFormat = "dddd, yyyy-MM-dd";
                };
            })
        ];

        services.xserver.enable = true;
        services.displayManager = {
            sddm = {
                enable = true;
                package = pkgs.kdePackages.sddm;

                theme = "sddm-astronaut-theme";

                extraPackages = [
                    pkgs.kdePackages.qtsvg
                    pkgs.kdePackages.qtmultimedia
                    pkgs.kdePackages.qtvirtualkeyboard
                    pkgs.kdePackages.qtdeclarative
                    pkgs.gst_all_1.gstreamer
                    pkgs.gst_all_1.gst-plugins-base
                    pkgs.gst_all_1.gst-plugins-good
                    pkgs.gst_all_1.gst-plugins-bad
                    pkgs.gst_all_1.gst-libav
                ];

                settings = {
                    General = {
                        InputMethod = "qtvirtualkeyboard";
                    };
                };
            };
        };

        systemd.services.display-manager.environment = {
            QT_IM_MODULE = "qtvirtualkeyboard";
            QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = "1";
        };

        security.pam.services.sddm.enableGnomeKeyring = true;
        modules.keyring.enable = true;
    };
}
