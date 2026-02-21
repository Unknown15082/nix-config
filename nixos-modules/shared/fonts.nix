{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.fonts;
in
{
    options.modules.fonts = {
        all = lib.mkEnableOption "all configured fonts";
        # TODO: Add custom options for each subsets
    };

    config = {
        fonts.packages =
            with pkgs;
            lib.optionals cfg.all [
                jetbrains-mono
                nerd-fonts.jetbrains-mono

                dejavu_fonts

                noto-fonts-cjk-sans
                noto-fonts-cjk-serif
            ];
    };
}
