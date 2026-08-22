{
    lib,
    config,
    pkgs,
    inputs,
    ...
}:
let
    cfg = config.modules.services;
    serviceCfg = cfg.apps.headscale;
    domainName = cfg.domainName;

    # format = pkgs.formats.yaml { };
    # fixedSettings = lib.recursiveUpdate config.services.headscale.settings {
    #     acme_email = "/dev/null";
    #     tls_cert_path = "/dev/null";
    #     tls_key_path = "/dev/null";
    #     policy.path = "/dev/null";
    #     oidc.client_secret_path = "/dev/null";
    # };
    # headscaleConfig = format.generate "headscale.yml" fixedSettings;

    headplaneReverseProxy = lib.optionalString serviceCfg.headplane.enable ''
        redir /admin /admin/
        reverse_proxy /admin/* :${toString serviceCfg.headplane.port}
    '';
in
{
    # imports = [
    #     inputs.headplane.nixosModules.headplane
    #     { nixpkgs.overlays = [ inputs.headplane.overlays.default ]; }
    # ];

    options.modules.services.apps.headscale = {
        enable = lib.mkEnableOption "service: headscale";
        port = lib.mkOption {
            description = "The exposed port";
            type = lib.types.int;
            default = 7004;
        };

        headplane = {
            enable = lib.mkEnableOption "service: headplane";
            port = lib.mkOption {
                description = "The exposed port";
                type = lib.types.int;
                default = 7005;
            };
        };
    };

    config = lib.mkIf serviceCfg.enable {
        age.secrets.headplane_cookie = {
            file = "${inputs.secrets}/headplane.age";
            mode = "400";
            owner = "headscale";
            group = "headscale";
        };

        age.secrets.headplane_preauth = {
            file = "${inputs.secrets}/tailscale_preauth.age";
            mode = "400";
            owner = "headscale";
            group = "headscale";
        };

        modules.services.caddyHosts."hs" = {
            reverseProxyPort = serviceCfg.port;
            extraConfig = ''
                ${headplaneReverseProxy}
            '';
        };

        modules.tailscale = {
            enable = true;
            serverFeatures = true;
        };

        services.headscale = {
            enable = true;
            address = "0.0.0.0";
            port = serviceCfg.port;

            settings = {
                server_url = "https://hs.${domainName}";

                dns = {
                    base_domain = "ts.net";
                    override_local_dns = false;
                };

                noise.private_key_path = "/var/lib/headscale/noise_private.key";
            };
        };

        # TODO: Temporarily removed.
        # services.headplane =
        #     with serviceCfg.headplane;
        #     lib.mkIf enable {
        #         enable = true;
        #         settings = {
        #             server = {
        #                 host = "0.0.0.0";
        #                 port = port;
        #                 cookie_secret_path = config.age.secrets.headplane_cookie.path;
        #                 cookie_secure = true;
        #             };
        #             headscale = {
        #                 url = config.services.headscale.settings.server_url;
        #                 config_path = headscaleConfig;
        #                 config_strict = true;
        #             };
        #             integration.proc.enabled = true;
        #             integration.agent = {
        #                 enabled = true;
        #                 pre_authkey_path = config.age.secrets.headplane_preauth.path;
        #             };
        #         };
        #     };
    };
}
