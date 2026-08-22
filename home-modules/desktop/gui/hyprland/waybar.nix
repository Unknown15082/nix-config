{
    lib,
    config,
    system,
    waybar,
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

            package = waybar.packages.${system}.default;

            style = lib.concatStringsSep "\n" [
                (lib.readFile ./colors.css)
                (lib.readFile ./waybar.css)
            ];

            settings.mainBar = {
                position = "top";

                margin-top = 6;
                margin-left = 8;
                margin-right = 8;

                modules-left = [
                    "hyprland/workspaces"
                    "mpris"
                ];
                modules-center = [
                    "clock"
                ];
                modules-right = [
                    "cpu"
                    "disk"
                    "battery"
                    "wireplumber"
                    "network"
                    "tray"
                ];

                "hyprland/workspaces" = {
                    format = "{name}";
                    on-scroll-down = "hyprctl dispatch \"hl.dsp.focus({ workspace = 'e-1' })\"";
                    on-scroll-up = "hyprctl dispatch \"hl.dsp.focus({ workspace = 'e+1' })\"";

                    move-to-monitor = true;
                    show-special = true;

                    tooltip = true;
                    tooltips.default = "{name}: {windows}";
                    window-rewrite-default = "{icon}";
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

                "mpris" = {
                    format = "{status_icon}  {title} [{position} / {length}]";
                    tooltip-format = "{album} :: {artist} - {title} [{position} / {length}]";

                    interval = 1;

                    on-click = "playerctl play-pause";
                    on-click-backward = "playerctl previous";
                    on-click-forward = "playerctl next";

                    status-icons = {
                        playing = "";
                        paused = "▶";
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
