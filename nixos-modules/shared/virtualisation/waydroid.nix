{
    lib,
    libutils,
    config,
    ...
}:
let
    cfg = config.modules.virtualisation.waydroid;
in
{
    options.modules.virtualisation.waydroid = {
        enable = lib.mkEnableOption "Waydroid";
    };

    config = lib.mkIf cfg.enable {
        virtualisation.waydroid.enable = true;
    };
}
