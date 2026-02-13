{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.services;
in
{
    options.modules.services = {
        enable = lib.mkEnableOption "servicesing softwares";

        domainName = lib.mkOption {
            description = "The default domain name used";
            type = lib.types.str;
        };

        reverseProxy = lib.mkOption {
            description = "Reverse proxy used";
            type = lib.types.enum [ "caddy" ];
        };
    };

    config = lib.mkIf cfg.enable {
        networking.firewall = {
            allowedTCPPorts = [
                80
                443
            ];
        };

        virtualisation.oci-containers.backend = "podman";
    };
}
