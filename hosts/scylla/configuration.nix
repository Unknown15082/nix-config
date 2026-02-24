{ pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./disko-config.nix
    ];

    presets.server.enable = true;

    system.stateVersion = "25.05";

    networking.hostName = "scylla";
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

        dive
        podman-tui
        podman-compose
    ];

    virtualisation.containers.enable = true;
    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
    };

    # Domain Name
    modules.services = {
        enable = true;
        domainName = "huytran.me";
        reverseProxy = "caddy";

        apps = {
            test.enable = true;
            otterwiki.enable = true;
            paperless.enable = true;
            headscale = {
                enable = true;
                headplane.enable = true;
            };
            silverbullet.enable = true;
            pocket-id.enable = true;
        };
    };
}
