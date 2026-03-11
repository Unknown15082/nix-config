{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.webpage;
in
{
    options.modules.services.apps.webpage = {
        enable = lib.mkEnableOption "personal webpage";

        path = lib.mkOption {
            type = lib.types.str;
            description = "Path to serve webpages";
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."${cfg.domainName}".extraConfig = ''
                				root * ${serviceCfg.path}
                				encode zstd gzip
                				file_server
                			'';
        };

        users.users.deploy = {
            isSystemUser = true;
            group = "deploy";
            shell = pkgs.bash;

            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKk1o7UCeF2n96aydxKCDjD4rDdG/P5PY+NgFV0mZ8Ju github-actions"
            ];
        };
        users.groups.deploy = { };

        systemd.tmpfiles.rules = [
            "d ${serviceCfg.path} 755 deploy deploy"
        ];
    };
}
