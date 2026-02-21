{ lib, config, ... }:
let
    cfg = config.presets.server;
in
{
    options.presets.server = {
        enable = lib.mkEnableOption "server preset";
    };

    config = lib.mkIf cfg.enable {
        presets.base.enable = true;

        modules = {
            # virtualisation = {
            #     docker.enable = true;
            #     libvirtd.enable = true;
            # };
        };

        boot.tmp.cleanOnBoot = true;
        zramSwap.enable = true;
        services.openssh.enable = true;
    };
}
