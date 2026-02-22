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

            systemd-boot.timeout = 3;
        };

        boot.tmp.cleanOnBoot = true;
        zramSwap.enable = true;
        services.openssh = {
            enable = true;
            settings.PasswordAuthentication = false;
        };
    };
}
