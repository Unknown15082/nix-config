{ lib, config, ... }:
let
    cfg = config.modules.networking;
in
{
    options.modules.networking = {
        enable = lib.mkEnableOption "networking";

        nameservers = {
            google = lib.mkEnableOption "Google DNS servers";
            cloudflare = lib.mkEnableOption "Cloudflare DNS servers";
        };
    };

    config = lib.mkIf cfg.enable {
        networking.networkmanager = {
            enable = true;
            insertNameservers =
                (lib.optionals cfg.nameservers.google [
                    "8.8.8.8"
                    "8.8.4.4"
                ])
                ++ (lib.optionals cfg.nameservers.cloudflare [
                    "1.1.1.1"
                    "1.0.0.1"
                ]);
        };

        modules.users.extraGroups = [ "networkmanager" ];
    };
}
