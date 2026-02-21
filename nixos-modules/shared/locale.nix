{ lib, config, ... }:
let
    cfg = config.modules.locale;
in
{
    options.modules.locale = {
        enable = lib.mkEnableOption "locale settings";
    };

    config = lib.mkIf cfg.enable {
        i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" ];
        i18n.extraLocaleSettings = {
            LC_TIME = "en_GB.UTF-8";
        };
    };
}
