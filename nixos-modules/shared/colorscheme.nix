{
    lib,
    config,
    ...
}:
let
    cfg = config.modules.colorscheme;
in
{
    options.modules.colorscheme = {
        catppuccin = lib.mkEnableOption "Catppuccin colorscheme";
    };

    config = (
        lib.mkIf cfg.catppuccin {
            # TODO: Move catppuccin imports here
            catppuccin.enable = true;
            catppuccin.autoEnable = false;

            hm = {
                catppuccin.enable = true;
                catppuccin.autoEnable = false;
            };
        }
    );
}
