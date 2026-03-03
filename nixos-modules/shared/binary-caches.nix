{ lib, config, ... }:
let
    cfg = config.modules.binary-caches;
in
{
    options.modules.binary-caches =
        with lib;
        mkOption {
            type = types.listOf (
                types.submodule {
                    options = {
                        url = mkOption {
                            type = types.str;
                            description = "URL of binary cache";
                        };

                        key = mkOption {
                            type = types.str;
                            description = "Public key of binary cache";
                        };

                        priority = mkOption {
                            type = types.int;
                            description = "Priority of binary cache. Lower number indicates a higher priority";
                            default = 10;
                        };
                    };
                }
            );
        };

    config = {
        nix.settings =
            let
                caches = map (v: "${v.url}?priority=${toString v.priority}") cfg;
                keys = map (v: v.key) cfg;
            in
            rec {
                substituters = lib.mkForce caches;
                trusted-substituters = lib.mkForce caches;
                trusted-public-keys = lib.mkForce keys;
            };
    };
}
