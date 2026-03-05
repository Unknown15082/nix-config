{ lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./disk-config.nix
        ./networking.nix
    ];

    presets.server.enable = true;

    system.stateVersion = "26.05";

    networking.hostName = "banshee";
    # TODO: Use modules.users.keys and myvars.publicKeys
    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILeIOQzu+mY5V0Gll45muIwqjACIOdqNP2JuE5G8vyYM"
    ];
    users.users.root.initialPassword = "";

    boot.loader = {
        systemd-boot.enable = lib.mkForce false;
        grub = {
            enable = true;
            efiSupport = false;
            devices = lib.mkForce [ "/dev/vda" ];
        };
    };

    networking.useDHCP = lib.mkForce false;
    systemd.network.enable = lib.mkForce false;

    modules.users.username = "root";

    environment.systemPackages = with pkgs; [
        neovim
        git
        btop
        ghostty.terminfo
    ];
    services.do-agent.enable = true;

    modules.tailscale = {
        enable = true;
        serverFeatures = true;
    };
}
