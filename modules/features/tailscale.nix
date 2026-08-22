{ self, ... }: {
    flake.modules.nixos.tailscale = {
        services.tailscale = {
            enable = true;
            useRoutingFeatures = "both";
        };

        home-manager.sharedModules = [
            self.modules.homeManager.tailscale
        ];
    };

    flake.modules.homeManager.tailscale = {
        services.tailscale-systray.enable = true;
    };
}
