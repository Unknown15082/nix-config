{ self, ... }: {
    flake.modules.nixos.presets-base = {
        imports = with self.modules.nixos; [
            kernel
            systemd-boot
            # limine
            networkManager
            openssh
            agenix

            nixSettings
            locale
            timezone
            allFonts
            iconTheme
            fish
        ];
    };

    flake.modules.nixos.presets-desktop = {
        imports = with self.modules.nixos; [
            presets-base

            hyprland

            audio
            bluetooth
            catppuccin
            keyd

            sddm
            sddmTheme

            protonvpn
        ];
    };
}
