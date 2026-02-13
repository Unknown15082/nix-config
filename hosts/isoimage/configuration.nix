{
    pkgs,
    modulesPath,
    system,
    inputs,
    ...
}:
{
    imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ];

    # ISO file setup
    isoImage = {
        edition = "custom";
        makeEfiBootable = true;
        makeUsbBootable = true;
        squashfsCompression = "gzip -Xcompression-level 1";
    };

    # Nix setup
    nixpkgs.hostPlatform = "x86_64-linux";
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # Networking
    # We use NetworkManager instead of wpa_supplicant
    networking.wireless.enable = false;
    networking.networkmanager.enable = true;

    # Explicitly enable port 22 for SSH
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.firewall.allowedUDPPorts = [ 22 ];

    # SSH
    services.openssh.enable = true;
    systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    users.users.nixos.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPZG7cZYt6YbE1/sQsAXGKpK22+CIOBe8L6LTZwYCSR .iso-only SSH key"
    ];
    security.sudo.wheelNeedsPassword = false; # password-less sudo

    # Additional packages
    environment.systemPackages = with pkgs; [
        # Custom neovim
        inputs.nixvim-config.packages.${system}.default

        # disko-install for systems that is configured with disko
        inputs.disko.packages.${system}.disko-install

        # Other packages
        git
        just
        lynx
    ];

    # Set Neovim as default editor
    environment.variables = {
        EDITOR = "nvim";
    };
}
