{ ... }: {
    flake.modules.homeManager.mailClient = { pkgs, ... }: {
        home.packages = [
            pkgs.fastmail-desktop
        ];
    };
}
