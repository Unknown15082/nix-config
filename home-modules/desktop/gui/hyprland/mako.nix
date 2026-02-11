{ lib, libutils, config, ... }:
let
	cfg = config.modules.mako;
in
{
	options.modules.mako = {
		enable = lib.mkEnableOption "Mako";
	};

	config = lib.mkIf cfg.enable {
		services.mako = {
			enable = true;
			settings = {
				layer = "overlay";
				default-timeout = 10000; # 10000ms = 10s
			};
		};
	};
}
