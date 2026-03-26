{ lib, config, ... }:
let
    cfg = config.modules.services.postgresql;
in
{
    options.modules.services.postgresql = {
        enable = lib.mkEnableOption "the central PostgreSQL database";

        ensureLists = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "List of users and databases to be created.";
            default = [ ];
        };
    };

    config = lib.mkIf cfg.enable {
        services.postgresql = {
            enable = true;
            ensureDatabases = cfg.ensureLists;
            ensureUsers = map (name: {
                inherit name;
                ensureDBOwnership = true;
            }) cfg.ensureLists;
        };
    };
}
