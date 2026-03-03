{
    lib,
    config,
    inputs,
    system,
    pkgs,
    ...
}:
let
    cfg = config.modules.games.osu;
in
{
    options.modules.games.osu = {
        enable = lib.mkEnableOption "osu!";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [
            # Override to use dGPU
            inputs.nix-gaming.packages.${system}.osu-lazer-bin
        ];

        modules.binary-caches = [
            {
                url = "https://nix-gaming.cachix.org";
                key = "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=";
                priority = 20;
            }
        ];
    };
}
