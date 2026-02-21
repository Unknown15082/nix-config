{ lib, config, ... }:
let
    cfg = config.presets.base;
in
{
    options.presets.base = {
        enable = lib.mkEnableOption "base preset";
    };

    config = lib.mkIf cfg.enable {
        modules = {
            kernel.enable = true;
            systemd-boot.enable = true;
            nix-settings.enable = true;

            networking = {
                enable = true;
            };

            fonts.all = true;
            locale.enable = true;
        };
    };
}
