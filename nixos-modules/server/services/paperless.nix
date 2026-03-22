{
    lib,
    config,
    pkgs,
    secrets,
    username,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.paperless;
    domainName = cfg.domainName;

    paperless-no-check = pkgs.paperless-ngx.overrideAttrs (_: {
        doCheck = false;
    });
in
{
    options.modules.services.apps.paperless = {
        enable = lib.mkEnableOption "service: paperless-ngx";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7002;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        age.secrets.paperless_password = {
            file = "${secrets}/paperless.age";
            mode = "400";
            owner = config.services.paperless.user;
        };

        modules.services.caddyHosts."paper" = {
            reverseProxyPort = serviceCfg.port;
            tailscaleOnly = true;
        };

        services.paperless = {
            enable = true;
            package = paperless-no-check;
            address = "0.0.0.0";
            port = serviceCfg.port;

            passwordFile = config.age.secrets.paperless_password.path;

            settings = {
                PAPERLESS_URL = "https://paper.${domainName}";
                PAPERLESS_ADMIN_USER = "${username}";
                PAPERLESS_OCR_LANGUAGE = "eng";
                PAPERLESS_OCR_USER_ARGS = {
                    optimize = 1;
                    pdfa_image_compression = "lossless";
                };
            };
        };
    };
}
