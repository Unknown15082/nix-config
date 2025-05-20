{ lib, mylib, config, ... }:
let
	cfg = config.modules.mako;
in
{
	options.modules.mako = {
		enable = mylib.mkEnableTrueOption "Mako";
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
