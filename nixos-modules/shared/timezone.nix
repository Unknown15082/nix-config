{
    lib,
    libutils,
    config,
    ...
}:
let
    cfg = config.modules.timezone;
in
{
    options.modules.timezone = {
        enable = lib.mkEnableOption "Automatic timezone";
    };

    config = lib.mkIf cfg.enable {
        # services.automatic-timezoned.enable = true;
        # services.avahi.enable = true;
        # services.geoclue2 = {
        #     geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
        # };

        services.tzupdate = {
            enable = true;
            timer.enable = true;
            timer.interval = "minutely";
        };
    };
}
