{ lib, mylib, config, ... }:
let
	cfg = config.modules.hypridle;
in {
	options.modules.hypridle = {
		enable = mylib.mkEnableTrueOption "Hypridle";
	};

	config = lib.mkIf cfg.enable {
		services.hypridle = {
			enable = true;
			settings = {
				general = {
					lock_cmd = "hyprlock";
					ignore_dbus_inhibit = false;
					ignore_systemd_inhibit = false;
				};

				listener = [
					{
						timeout = 600;
						on-timeout = "brightnessctl set 30%";
						on-resume = "brightnessctl set 100%";
					}
					{
						timeout = 900;
						on-timeout = "hyprlock";
					}
					{
						timeout = 1200;
						on-timeout = "hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
				];
			};
		};
	};
}
