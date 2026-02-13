{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.keyboards.input-method;
in
{
    options.modules.keyboards.input-method = {
        vietnamese = {
            enable = lib.mkEnableOption "Vietnamese input method";
        };
        # TODO: Separate into Japanese option
    };

    config = lib.mkIf cfg.vietnamese.enable {
        i18n.inputMethod = {
            enable = true;
            type = "fcitx5";
            fcitx5 = {
                addons = [
                    pkgs.fcitx5-bamboo
                    pkgs.fcitx5-mozc
                ];
                waylandFrontend = true;

                settings = {
                    globalOptions = { };

                    inputMethod = {
                        "Groups/0" = {
                            Name = "Default";
                            DefaultIM = "keyboard-us-altgr-intl";
                            "Default Layout" = "us-altgr-intl";
                        };
                        "Groups/0/Items/0" = {
                            "Name" = "keyboard-us-altgr-intl";
                        };
                        "Groups/0/Items/1" = {
                            "Name" = "mozc";
                        };
                        "Groups/0/Items/2" = {
                            "Name" = "bamboo";
                        };
                    };
                };
            };
        };

        catppuccin.fcitx5 = {
            enable = true;
            flavor = "mocha";
        };

        hm = lib.mkIf config.modules.gnome.enable {
            home.packages = with pkgs.gnomeExtensions; [ kimpanel ];

            dconf = {
                enable = true;
                settings."org/gnome/shell" = {
                    disable-user-extensions = false;
                    enabled-extensions = with pkgs.gnomeExtensions; [
                        kimpanel.extensionUuid
                    ];
                };
            };
        };
    };
}
