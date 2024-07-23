{ lib, config, ... }:
let
	cfg = config.modules.docker;
in
{
	options.modules.docker = {
		enable = lib.mkEnableOption "docker";
	};

	config = lib.mkIf cfg.enable {
		virtualisation.docker = {
			enable = true;
			storageDriver = "btrfs";
		};
	};
}
