{ lib, config, myvars, ... }:
let
	cfg = config.modules.users;
in {
	options.modules.users = {
		username = lib.mkOption {
			description = "Name of the user";
			type = lib.types.str;
		};

		extraGroups = lib.mkOption {
			description = "List of extra groups the user belongs to";
			type = lib.types.listOf lib.types.str;
			default = [ "wheel" ];
		};
	};

	config = {
		users.users.${cfg.username} = {
			isNormalUser = true;
			description = cfg.username;
			extraGroups = cfg.extraGroups ++ [ "wheel" ];
			# TODO: hashPasswordFile
			# TODO: authorizedKeys
		};
	};
}
