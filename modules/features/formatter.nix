{ ... }: {
    perSystem = { pkgs, ... }: {
        formatter = pkgs.nixfmt-tree.override {
            settings.formatter.nixfmt = {
                options = [ "--indent=4" ];
            };
        };
    };
}
