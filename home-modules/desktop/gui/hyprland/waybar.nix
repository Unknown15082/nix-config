{ lib, libutils, config, ... }:
let
	cfg = config.modules.waybar;
in {
	options.modules.waybar = {
		enable = lib.mkEnableOption "Waybar";
	};

	config = lib.mkIf cfg.enable {
		programs.waybar = {
			enable = true;
			systemd.enable = true;
			
			settings.mainBar = {
				position = "left";

				modules-left = [
					"hyprland/workspaces"
				];
				modules-center = [
					"clock"
				];
				modules-right = [
					"battery"
					"tray"
				];

				"clock" = {
					format = "{:%H%n%M}";
					tooltip-format = "<tt>{calendar}</tt>";
					locale = "en_GB.UTF-8";
					calendar = {
						mode = "year";
						mode-mon-col = 4;
						format = {
							"months" = "<span color='#ffead3'><b>{}</b></span>";
							"days" = "<span color='#ecc6d9'><b>{}</b></span>";
							"weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
							"weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
							"today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
						};
					};
				};
			};
		};
	};
}
