{ self, ... }: {
    flake.modules.nixos.oled = {
        home-manager.sharedModules = [
            self.modules.homeManager.oled
        ];
    };

    flake.modules.homeManager.oled = { lib, ... }: {
        wayland.windowManager.hyprland.settings = {
            config = {
                general = {
                    col.active_border.colors = lib.mkForce [
                        "rgba(a6e3a166)"
                        "rgba(89dceb66)"
                    ];
                };
            };
        };

        programs.waybar = {
            settings.mainBar = {
                start_hidden = true;
            };
        };
    };
}
