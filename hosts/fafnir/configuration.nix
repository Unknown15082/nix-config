# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, myvars, ... }:

{
    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix

        # Include laptop-specific configs
        ./laptop.nix
    ];

    # Enable default desktop settings
    presets.desktop.enable = true;

    # Enable NUSVPN
    modules.nusvpn.enable = true;

    # Enable OpenTabletDriver
    hardware.opentabletdriver.enable = true;

    # Set Windows' device handle for systemd-boot
    modules.systemd-boot.windows_dual_boot = "HD0b";

    # Enable fish shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    modules.users.username = myvars.username;

    # Enable Tailscale
    modules.tailscale = {
        enable = true;
        clientFeatures = true;
        systray = true;
    };

    # Leave this option alone
    system.stateVersion = "23.11";

    # Manage fonts
    # TODO: Fonts
    fonts.packages = with pkgs; [
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        dejavu_fonts

        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
    ];

    # Enable GPG
    programs.gnupg = {
        agent = {
            enable = true;
            enableBrowserSocket = true;
            enableExtraSocket = true;
        };
    };

    # Disable command-not-found
    programs.command-not-found.enable = false;

    # Enable Hyprland
    modules.hyprland.enable = true;

    # Enable bt-sync
    modules.bluetooth.bt-sync.windows_partition = "nvme0n1p3";

    # Enable games
    modules.games.steam.enable = true;
    modules.games.osu.enable = true;
    modules.games.ffxiv.enable = true;

    # Enable Docker & libvirtd
    modules.virtualisation.docker.enable = true;
    modules.virtualisation.libvirtd.enable = true;

    # Enable keyboards modules
    modules.keyboards = {
        keyd = {
            enable = true;
            keyboardIds = [ "048d:c966" ];
        };
        qmk.enable = true;
        input-method.vietnamese.enable = true;
    };

    # Enable SSH
    services.openssh.enable = true;

    # Enable I2C
    hardware.i2c.enable = true;

    # Set locale
    # TODO: Locale
    i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" ];
    i18n.extraLocaleSettings = {
        LC_TIME = "en_GB.UTF-8";
    };

    # Auto timezone
    modules.automatic-timezoned.enable = true;
}
