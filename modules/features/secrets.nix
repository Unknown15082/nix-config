{ inputs, ... }: {
    flake.modules.nixos.agenix = { pkgs, ... }: {
        imports = [
            inputs.agenix.nixosModules.default
        ];

        nixpkgs.overlays = [ inputs.agenix.overlays.default ];
        environment.systemPackages = [ pkgs.agenix ];

        age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    flake.modules.homeManager.agenix = { config, ... }: {
        imports = [
            inputs.agenix.homeManagerModules.default
        ];

        age.identityPaths = [ "/home/${config.home.username}/.ssh/id_ed25519" ];
    };
}
