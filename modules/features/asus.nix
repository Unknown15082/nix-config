{ ... }: {
    flake.modules.nixos.asusd = {
        services.asusd = {
            enable = true;
        };

        systemd.services.asusd.wantedBy = [ "multi-user.target" ];
    };
}
