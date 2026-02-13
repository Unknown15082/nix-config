{
    lib,
    libutils,
    config,
    pkgs,
    username,
    ...
}:
let
    cfg = config.modules.keyring;
    uid = config.users.users.${username}.uid;
in
{
    options.modules.keyring = {
        enable = lib.mkEnableOption "GNOME Keyring";
    };

    config = lib.mkIf cfg.enable {
        services.gnome.gnome-keyring.enable = true;
        environment.systemPackages = [ pkgs.libsecret ];
        services.dbus.packages = [ pkgs.seahorse ];
        programs.seahorse.enable = true;

        environment.sessionVariables = {
            SSH_AUTH_SOCK = "/run/user/${builtins.toString uid}/keyring/ssh";
        };

        hm = {
            services.gnome-keyring = {
                enable = true;
                components = [
                    "pkcs11"
                    "secrets"
                    "ssh"
                ];
            };

            home.packages = [ pkgs.seahorse ];
        };
    };
}
