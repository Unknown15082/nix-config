{ lib, ... }:
{
    # This file was populated at runtime with the networking
    # details gathered from the active system.
    networking = {
        nameservers = [
            "8.8.8.8"
        ];
        defaultGateway = "167.71.192.1";
        defaultGateway6 = {
            address = "2400:6180:0:d2::1";
            interface = "eth0";
        };
        dhcpcd.enable = false;
        usePredictableInterfaceNames = lib.mkForce false;
        interfaces = {
            eth0 = {
                ipv4.addresses = [
                    {
                        address = "167.71.200.171";
                        prefixLength = 20;
                    }
                    {
                        address = "10.15.0.5";
                        prefixLength = 16;
                    }
                ];
                ipv6.addresses = [
                    {
                        address = "2400:6180:0:d2:0:1:8b3f:d000";
                        prefixLength = 64;
                    }
                    {
                        address = "fe80::4c9c:69ff:fe00:9b6c";
                        prefixLength = 64;
                    }
                ];
                ipv4.routes = [
                    {
                        address = "167.71.192.1";
                        prefixLength = 32;
                    }
                ];
                ipv6.routes = [
                    {
                        address = "2400:6180:0:d2::1";
                        prefixLength = 128;
                    }
                ];
            };
            eth1 = {
                ipv4.addresses = [
                    {
                        address = "10.104.0.2";
                        prefixLength = 20;
                    }
                ];
                ipv6.addresses = [
                    {
                        address = "fe80::d4ca:1cff:fed8:39d2";
                        prefixLength = 64;
                    }
                ];
            };
        };
    };
    services.udev.extraRules = ''
            ATTR{address}=="4e:9c:69:00:9b:6c", NAME="eth0"
            ATTR{address}=="d6:ca:1c:d8:39:d2", NAME="eth1"
            '';
}
