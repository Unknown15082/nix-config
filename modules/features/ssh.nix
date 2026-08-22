{ ... }: {
    flake.modules.nixos.openssh = { config, ... }: {
        services.openssh = {
            enable = true;

            generateHostKeys = true;
            hostKeys = [
                {
                    path = "/etc/ssh/ssh_host_ed25519_key";
                    type = "ed25519";
                    comment = "root@${config.networking.hostName}";
                }
            ];
        };
    };

    flake.modules.nixos.opensshDisablePassword = {
        services.openssh = {
            settings.PasswordAuthentication = false;
            settings.KbdInteractiveAuthentication = false;
        };
    };
}
