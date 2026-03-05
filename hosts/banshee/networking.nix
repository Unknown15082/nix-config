{
    networking = {
        useDHCP = false;

        interfaces.ens3 = {
            ipv4.addresses = [
                {
                    address = "146.190.98.199";
                    prefixLength = 20;
                }
                {
                    address = "10.15.0.5";
                    prefixLength = 16;
                }
            ];
            ipv4.routes = [
                {
                    address = "146.190.96.1";
                    prefixLength = 32;
                }
                {
                    address = "10.15.0.1";
                    prefixLength = 32;
                }
            ];

            ipv6.addresses = [
                {
                    address = "2400:6180:0:d2:0:2:b79b:1000";
                    prefixLength = 64;
                }
            ];
            ipv6.routes = [
                {
                    address = "2400:6180:0:d2::1";
                    prefixLength = 128;
                }
            ];
        };

        interfaces.ens4 = {
            ipv4.addresses = [
                {
                    address = "10.104.0.3";
                    prefixLength = 20;
                }
            ];
        };

        defaultGateway = {
            address = "10.15.0.1";
            interface = "ens3";
        };

        defaultGateway6 = {
            address = "2400:6180:0:d2::1";
            interface = "ens3";
        };

        nameservers = [
            "8.8.8.8"
            "8.8.4.4"
        ];
    };
}
