{ self, ... }: {
    flake.modules.nixos.systemd-boot = { lib, config, ... }: {
        options.settings.systemd-boot = {
            windows =
                with lib;
                mkOption {
                    type = types.nullOr types.str;
                    default = null;
                    description = ''
                        The device handle for Windows EFI partition.
                        Obtained from: https://search.nixos.org/options?channel=unstable&query=systemd-boot&type=options
                    '';
                };
        };

        config =
            let
                cfg = config.settings.systemd-boot;
            in
            {
                boot.loader = {
                    efi.canTouchEfiVariables = true;
                    timeout = 60;

                    systemd-boot = {
                        enable = true;
                        configurationLimit = 10;

                        edk2-uefi-shell.enable = true;
                        memtest86.enable = true;

                        bootCounting.enable = true;
                        bootCounting.tries = 3;

                        consoleMode = "max";

                        windows."11" = lib.mkIf (cfg.windows != null) {
                            title = "Windows 11";
                            sortKey = "a_windows";
                            efiDeviceHandle = cfg.windows;
                        };
                    };
                };
            };
    };

    flake.modules.nixos.limine = {
        imports = [
            self.modules.nixos.limineMemtest
        ];
        
        boot.loader.limine = {
            enable = true;

            maxGenerations = 10;

            resolution = "2880x1800";
            style = {
                interface.resolution = "2880x1800";
            };
        };
    };

    flake.modules.nixos.limineMemtest = { pkgs, ... }: {
        boot.loader.limine = {
            additionalFiles = {
                "efi/memtest86/memtest86.efi" = "${pkgs.memtest86-efi}/BOOTX64.efi";
            };

            extraEntries = ''
                /Memtest86+
                    protocol: chainload
                    path: boot():///efi/memtest86/memtest86.efi
            '';
        };
    };

    flake.modules.nixos.limineWindows = { lib, config, ... }: {
        options.settings.limine = {
            windows = with lib; mkOption {
                type = types.str;
                description = ''
                    The PARTUUID of the ESP partition for Windows.
                    Obtained from: sudo blkid
                '';
            };
        };

        config = let
            cfg = config.settings.limine;
        in {
            boot.loader.limine.extraEntries = ''
                /Windows
                    protocol: efi
                    path: uuid(${cfg.windows}):/EFI/Microsoft/Boot/bootmgfw.efi
            '';
        };
    };
}
