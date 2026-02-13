{
    lib,
    libutils,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.osd;
in
{
    options.modules.osd = {
        enable = lib.mkEnableOption "SwayOSD";
    };

    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
            swayosd
            brightnessctl
            jq
        ];
    };
}
