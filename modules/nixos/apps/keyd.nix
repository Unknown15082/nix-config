{ lib, config, pkgs, ... }:
let
	cfg = config.modules.keyd;
in
{
	options.modules.keyd = {
		enable = lib.mkEnableOption "KeyD";
		keyboardIds = lib.mkOption {
			type = lib.types.listOf lib.types.string;
			default = [ "*" ];
			description = "The list of keyboard ids, following keyd(1)";
		};
	};

	config = lib.mkIf cfg.enable {
		services.keyd.enable = true;
		services.keyd.keyboards = {
			default = {
				ids = cfg.keyboardIds;
				settings = {
					main = {
						# Change CapsLock key to Control/Escape (Hold-Tap)
						capslock = "overload(control, esc)";
					};
				};
			};
		};
	};
}
