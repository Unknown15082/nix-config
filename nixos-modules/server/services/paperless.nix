{
    lib,
    config,
    secrets,
    username,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.services.paperless;
    domainName = cfg.domainName;
in
{
    options.modules.services.services.paperless = {
        enable = lib.mkEnableOption "service: paperless-ngx";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
        };
    };

    config = lib.mkIf serviceCfg.enable {
        age.secrets.paperless_password = {
            file = "${secrets}/paperless.age";
            mode = "400";
            owner = config.services.paperless.user;
        };

        services.caddy = {
            virtualHosts."paper.${domainName}".extraConfig = ''
                				reverse_proxy :${toString serviceCfg.port}
                			'';
        };

        services.paperless = {
            enable = true;
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
