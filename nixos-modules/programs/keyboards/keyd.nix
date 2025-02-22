{ lib, config, ... }:
let
	cfg = config.modules.keyboards.keyd;
in
{
	options.modules.keyboards.keyd = {
		enable = lib.mkEnableOption "KeyD";
		keyboardIds = lib.mkOption {
			type = lib.types.listOf lib.types.str;
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
