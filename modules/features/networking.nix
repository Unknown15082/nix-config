{ inputs, ... }: {
    flake.modules.nixos.networkManager = { pkgs, ... }: {
        networking.networkmanager = {
            enable = true;

            plugins = with pkgs; [
                networkmanager-openvpn
            ];
        };

        settings.userGroups = [ "networkmanager" ];
    };

    flake.modules.nixos.googleNameserver = {
        networking.networkmanager.insertNameservers = [
            "8.8.8.8"
            "8.8.4.4"
        ];
    };

    flake.modules.nixos.cloudflareNameserver = {
        networking.networkmanager.insertNameservers = [
            "1.1.1.1"
            "1.0.0.1"
        ];
    };

    flake.modules.nixos.protonvpn = { lib, config, pkgs, ... }: {
        age.secrets.protonvpn = {
            file = "${inputs.secrets}/proton.age";
            mode = "770";
            group = "networkmanager";
        };

        networking.wg-quick.interfaces.protonvpn = {
            autostart = false;
            dns = [ "10.2.0.1" "2a07:b944::2:1" ];
            privateKeyFile = config.age.secrets.protonvpn.path;
            address = [ "10.2.0.2/32" "2a07:b944::2:2/128" ];
            listenPort = 51820;

            peers = [
                {
                    publicKey = "nwlXvRGPmqXIlMFt5MAO6KoVHmgTk2AZbPMXXkDaxQM="; # TODO: Move to secret management
                    allowedIPs = [ "0.0.0.0/0" "::/0" ];
                    endpoint = "149.50.211.165:51820";
                }
            ];
        };

        environment.systemPackages = [
            (let
                systemctl = lib.getExe' pkgs.systemd "systemctl";
                vpnName = "wg-quick-protonvpn";
            in pkgs.writeShellScriptBin "protonvpn" ''
                if ${systemctl} is-active --quiet ${vpnName}; then
                    sudo systemctl stop ${vpnName}
                else
                    sudo systemctl start ${vpnName}
                fi
            '')
        ];
    };
}
