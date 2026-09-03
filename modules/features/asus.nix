{ inputs, ... }: {
    flake.modules.nixos.asusd = {
        services.asusd = {
            enable = true;
        };

        systemd.services.asusd.wantedBy = [ "multi-user.target" ];
    };

    flake.modules.nixos.asusNumberPad = {
        imports = [
            inputs.asus-numberpad-driver.nixosModules.default
        ];

        services.asus-numberpad-driver = {
            enable = true;
            layout = "up5401ea";

            wayland = true;
            waylandDisplay = "wayland-1";
        };
    };
}
