{ lib, osConfig, ... }:
let
	cfg = osConfig.modules.stylix;
in
{
	config = lib.mkIf cfg.enable {
		stylix.targets = {
			fish.enable = false;
		};
	};
}
