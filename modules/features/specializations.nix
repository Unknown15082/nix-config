{ ... }: {
    flake.modules.nixos.specialization-presenting = { lib, ... }: {
        specialisation = {
            presenting.configuration = {
                home-manager.sharedModules = [{
                    services.hypridle.enable = lib.mkForce false;
                    services.mako.enable = lib.mkForce false;
                }];
            };
        };
    };
}
