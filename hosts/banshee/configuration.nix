{ pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./disk-config.nix
        ./digital-ocean.nix
    ];

    presets.server.enable = true;

    system.stateVersion = "26.05";

    networking.hostName = "banshee";
    # TODO: Use modules.users.keys and myvars.publicKeys
    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILeIOQzu+mY5V0Gll45muIwqjACIOdqNP2JuE5G8vyYM"
    ];

    modules.users.username = "root";

    environment.systemPackages = with pkgs; [
        neovim
        git
        btop
        ghostty.terminfo
    ];

    modules.tailscale = {
        enable = true;
        serverFeatures = true;
    };
}
