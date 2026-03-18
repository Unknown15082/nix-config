{
    lib,
    config,
    secrets,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.stump;
    domainName = cfg.domainName;
in
{
    options.modules.services.apps.stump = {
        enable = lib.mkEnableOption "service: stump";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7011;
        };

        dataDir = lib.mkOption {
            description = "Data directory";
            type = lib.types.str;
            default = "/var/lib/stump";
        };
    };

    config = lib.mkIf serviceCfg.enable {
        services.caddy = {
            virtualHosts."stump.${domainName}".extraConfig = ''
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        age.secrets.stump = {
            file = "${secrets}/stump.age";
            mode = "400";
            owner = "stump";
            group = "stump";
        };

        systemd.tmpfiles.rules = with serviceCfg; [
            "d ${dataDir}/data 755 stump stump"
            "d ${dataDir}/config 755 stump stump"
        ];

        virtualisation.oci-containers = {
            containers.stump = {
                environment = {
                    PUID = toString config.users.users.stump.uid;
                    PGID = toString config.users.groups.stump.gid;
                    STUMP_CONFIG_DIR = "/config";

                    ENABLE_KOREADER_SYNC = "true";
                    ENABLE_OPDS_PROGRESSION = "true";
                    STUMP_ENABLE_UPLOAD = "true";

                    STUMP_OIDC_ENABLED = "true";
                    STUMP_OIDC_ISSUER_URL = "https://pocketid.${domainName}";
                    # STUMP_OIDC_CLIENT_ID -> secrets
                    # STUMP_OIDC_CLIENT_SECRET -> secrets
                    STUMP_OIDC_DISABLE_LOCAL_AUTH = "true";
                };
                environmentFiles = [ config.age.secrets.stump.path ];

                image = "aaronleopold/stump:nightly";
                pull = "newer";

                ports = [ "${toString serviceCfg.port}:10801" ];
                volumes = [
                    "${serviceCfg.dataDir}/data:/data"
                    "${serviceCfg.dataDir}/config:/config"
                ];
            };
        };

        users.users.stump = {
            isSystemUser = true;
            uid = 2003;
            group = "stump";
        };
        users.groups.stump = {
            gid = 2003;
        };
    };
}
