{
    lib,
    config,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.grimmory;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.grimmory = {
        enable = lib.mkEnableOption "service: grimmory";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7009;
        };

        dataDir = lib.mkOption {
            description = "Data directory";
            type = lib.types.str;
            default = "/var/lib/grimmory";
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."book.${domainName}".extraConfig = ''
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        age.secrets.grimmory = {
            file = "${secrets}/grimmory.age";
            mode = "400";
            owner = "root";
        };

        systemd.tmpfiles.rules = with serviceCfg; [
            "d ${dataDir}/data 755 root root"
            "d ${dataDir}/books 755 root root"
            "d ${dataDir}/bookdrop 755 root root"
            "d ${dataDir}/db 755 root root"
        ];

        virtualisation.oci-containers = {
            containers.grimmory-db = {
                environment = {
                    PUID = "1000";
                    PGID = "1000";
                };
                environmentFiles = [ config.age.secrets.grimmory.path ];

                image = "lscr.io/linuxserver/mariadb:11.4.5";

                volumes = [
                    "${serviceCfg.dataDir}/db:/config"
                ];
            };

            containers.grimmory = {
                environment = {
                    USER_ID = "0";
                    GROUP_ID = "0";
                    BOOKLORE_PORT = toString serviceCfg.port;
                };
                environmentFiles = [ config.age.secrets.grimmory.path ];

                image = "ghcr.io/grimmory-tools/grimmory:latest";
                pull = "newer";
                dependsOn = [ "grimmory-db" ];

                ports = [ "${toString serviceCfg.port}:${toString serviceCfg.port}" ];
                volumes = [
                    "${serviceCfg.dataDir}/data:/app/data"
                    "${serviceCfg.dataDir}/books:/books"
                    "${serviceCfg.dataDir}/bookdrop:/bookdrop"
                ];
            };
        };
    };
}
