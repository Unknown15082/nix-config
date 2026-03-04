{
    lib,
    libutils,
    config,
    pkgs,
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

        systemd.user.services.update-tz-env = {
            description = "Update TZ from /etc/localtime";
            serviceConfig = {
                Type = "oneshot";
                ExecStart = [
                    "${pkgs.systemd}/bin/systemctl"
                    "--user"
                    "set-environment"
                    "TZ=$(readlink /etc/localtime | sed 's|.*zoneinfo/||')"
                ];
            };
            wantedBy = [ "default.target" ];
        };
    };
}
