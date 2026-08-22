{ self, inputs, ... }: let
    accent = "sapphire";
    flavor = "mocha";
in {
    flake.modules.nixos.catppuccin = {
        imports = [
            inputs.catppuccin.nixosModules.catppuccin
        ];

        home-manager.sharedModules = [
            self.modules.homeManager.catppuccin
        ];

        catppuccin = {
            enable = true;
            autoEnable = false;
            inherit accent flavor;
        };

        # Enable catppuccin's binary cache
        settings.binaryCaches.caches = [
            {
                url = "https://catppuccin.cachix.org";
                key = "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU=";
            }
        ];
    };

    flake.modules.homeManager.catppuccin = {
        imports = [
            inputs.catppuccin.homeModules.catppuccin
        ];

        catppuccin = {
            enable = true;
            autoEnable = false;
            inherit accent flavor;
        };
    };
}
