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

        nix.settings = {
            substituters = [ "https://nix-gaming.cachix.org" ];
            trusted-public-keys = [
                "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
            ];
        };
    };
}
