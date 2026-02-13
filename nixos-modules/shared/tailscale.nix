{ lib, config, ... }:
let
    cfg = config.modules.tailscale;

    useRoutingFeatures =
        if cfg.clientFeatures then
            (if cfg.serverFeatures then "both" else "client")
        else
            (if cfg.serverFeatures then "server" else "none");
in
{
    options.modules.tailscale = {
        enable = lib.mkEnableOption "Tailscale";

        clientFeatures = lib.mkEnableOption "client routing features";
        serverFeatures = lib.mkEnableOption "server routing features";
        systray = lib.mkEnableOption "native Tailscale systray";
    };

    config = lib.mkIf cfg.enable {
        services.tailscale = {
            enable = true;
            inherit useRoutingFeatures;
        };

        hm.services.tailscale-systray.enable = cfg.systray;
    };
}
