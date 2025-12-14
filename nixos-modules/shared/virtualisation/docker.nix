{ lib, config, ... }:
let
	cfg = config.modules.virtualisation.docker;
in
{
	options.modules.virtualisation.docker = {
		enable = lib.mkEnableOption "docker";
	};

	config = lib.mkIf cfg.enable {
		# TODO: Change to podman and podman-compose
		virtualisation.docker = {
			enable = true;
		};

		modules.users.extraGroups = [ "docker" ];
	};
}
