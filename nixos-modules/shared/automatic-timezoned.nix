{
    lib,
    libutils,
    config,
    ...
}:
let
    cfg = config.modules.automatic-timezoned;
in
{
    options.modules.automatic-timezoned = {
        enable = lib.mkEnableOption "Automatic timezone";
    };

    config = lib.mkIf cfg.enable {
        services.automatic-timezoned.enable = true;
        services.avahi.enable = true;
        services.geoclue2 = {
            geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
        };
    };
}
