{
    lib,
    libutils,
    config,
    ...
}:
let
    cfg = config.modules.waybar;
in
{
    options.modules.waybar = {
        enable = lib.mkEnableOption "Waybar";
    };

    config = lib.mkIf cfg.enable {
        programs.waybar = {
            enable = true;
            systemd.enable = true;

            settings.mainBar = {
                position = "top";

                modules-left = [
                    "hyprland/workspaces"
					"mpris"
                ];
                modules-center = [
                    "clock"
                ];
                modules-right = [
                    "battery"
					"network"
                    "tray"
                ];

				"hyprland/workspaces" = {
					format = "{name}";
					cursor = true;
					on-scroll-down = "hyprctl dispatch \"hl.dsp.focus({ workspace = 'e-1' })\"";
					on-scroll-up = "hyprctl dispatch \"hl.dsp.focus({ workspace = 'e+1' })\"";
				};

				"battery" = {
					interval = 20;
					tooltip = true;
					format = "{icon} {capacity}%";
					format-time = "{H}:{M:02}";
					format-charging = " {capacity}% ({time})";
					format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂂" "󰁹"];
					states = {
						warning = 30;
						critical = 10;
					};
				};

                "clock" = {
                    format = "{:%H:%M}";
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
