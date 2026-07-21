{ lib, config, ... }:
let
    exec = app: "hl.dsp.exec_cmd(\"${app}\")";
    args = a1: a2: {
        _args = [
            a1
            a2
        ];
    };
    bind = a1: a2: args a1 (lib.generators.mkLuaInline a2);
    bind3 = a1: a2: a3: {
        _args = [
            a1
            (lib.generators.mkLuaInline a2)
            a3
        ];
    };

    mod = "SUPER";
    terminal = "ghostty";
    browser = "firefox";
    launcher = "rofi -show drun";
    runner = "$SHELL -c \\\"$(rofi -dmenu -p '' -l 0)\\\"";
    screenshot = "grimblast copysave area";
in
{
    wayland.windowManager.hyprland.settings = {
        #--- MONITORS ---#
        monitor = {
            output = "";
            mode = "highrr";
            position = "auto";
            scale = 1;
        };

        #--- CONFIG ---#
        config = {
            general = {
                border_size = 2;
                gaps_in = 3;
                gaps_out = 5;
                col = {
                    active_border = {
                        colors = [
                            "rgba(a6e3a1ee)"
                            "rgba(89dcebee)"
                        ];
                        angle = 45;
                    };
                    inactive_border = "rgba(6c7086aa)";
                };
                resize_on_border = false;
                allow_tearing = false;
                layout = "scrolling";
            };

            decoration = {
                active_opacity = 1;

                rounding = 5;

                shadow = {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };

                blur = {
                    enabled = true;
                    size = 8;
                    passes = 2;

                    ignore_opacity = true;
                    new_optimizations = true;

                    vibrancy = 0.1696;
                    vibrancy_darkness = 0.5;
                };
            };

            animations = {
                enabled = true;
            };

            input = {
                kb_layout = "us";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";

                follow_mouse = 1;
                sensitivity = 0;
                accel_profile = "flat";

                touchpad.natural_scroll = true;
            };

            xwayland = {
                force_zero_scaling = true;
            };

            misc = {
                force_default_wallpaper = 0;
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
                enable_anr_dialog = false;
                close_special_on_empty = false;
            };

            binds = {
                hide_special_on_workspace_change = true;
            };

            ecosystem = {
                no_update_news = true;
                no_donation_nag = true;
            };

            dwindle = {
                preserve_split = true;
            };

            master = {
                mfact = "0.5";
                new_status = "master";
            };

            scrolling = {
                fullscreen_on_one_column = true;
				wrap_focus = false;
            };
        };

        #--- ANIMATIONS ---#
        curve = [
            (args "easeOutQuint" {
                type = "bezier";
                points = [
                    [
                        0.23
                        1
                    ]
                    [
                        0.32
                        1
                    ]
                ];
            })
            (args "easeInOutCubic" {
                type = "bezier";
                points = [
                    [
                        0.65
                        0.05
                    ]
                    [
                        0.36
                        1
                    ]
                ];
            })
            (args "linear" {
                type = "bezier";
                points = [
                    [
                        0
                        0
                    ]
                    [
                        1
                        1
                    ]
                ];
            })
            (args "almostLinear" {
                type = "bezier";
                points = [
                    [
                        0.5
                        0.5
                    ]
                    [
                        0.75
                        1
                    ]
                ];
            })
            (args "quick" {
                type = "bezier";
                points = [
                    [
                        0.15
                        0
                    ]
                    [
                        0.1
                        1
                    ]
                ];
            })
            (args "easy" {
                type = "spring";
                mass = 1;
                stiffness = 71.2633;
                dampening = 15.8273644;
            })
        ];

        animation = [
            {
                leaf = "global";
                enabled = true;
                speed = 10;
                bezier = "default";
            }
            {
                leaf = "border";
                enabled = true;
                speed = 5.39;
                bezier = "easeOutQuint";
            }
            {
                leaf = "windows";
                enabled = true;
                speed = 4.79;
                spring = "easy";
            }
            {
                leaf = "windowsIn";
                enabled = true;
                speed = 4.1;
                spring = "easy";
                style = "popin 87%";
            }
            {
                leaf = "windowsOut";
                enabled = true;
                speed = 1.49;
                bezier = "linear";
                style = "popin 87%";
            }
            {
                leaf = "fadeIn";
                enabled = true;
                speed = 1.73;
                bezier = "almostLinear";
            }
            {
                leaf = "fadeOut";
                enabled = true;
                speed = 1.46;
                bezier = "almostLinear";
            }
            {
                leaf = "fade";
                enabled = true;
                speed = 3.03;
                bezier = "quick";
            }
            {
                leaf = "layers";
                enabled = true;
                speed = 3.81;
                bezier = "easeOutQuint";
            }
            {
                leaf = "layersIn";
                enabled = true;
                speed = 4;
                bezier = "easeOutQuint";
                style = "fade";
            }
            {
                leaf = "layersOut";
                enabled = true;
                speed = 1.5;
                bezier = "linear";
                style = "fade";
            }
            {
                leaf = "fadeLayersIn";
                enabled = true;
                speed = 1.79;
                bezier = "almostLinear";
            }
            {
                leaf = "fadeLayersOut";
                enabled = true;
                speed = 1.39;
                bezier = "almostLinear";
            }
            {
                leaf = "workspaces";
                enabled = true;
                speed = 1.94;
                bezier = "almostLinear";
                style = "fade";
            }
            {
                leaf = "workspacesIn";
                enabled = true;
                speed = 1.21;
                bezier = "almostLinear";
                style = "fade";
            }
            {
                leaf = "workspacesOut";
                enabled = true;
                speed = 1.94;
                bezier = "almostLinear";
                style = "fade";
            }
            {
                leaf = "zoomFactor";
                enabled = true;
                speed = 7;
                bezier = "quick";
            }
        ];

        #--- GESTURES ---#
        gesture = [
            {
                fingers = 3;
                direction = "horizontal";
                action = "scroll_move";
            }
            {
                fingers = 4;
                direction = "horizontal";
                action = "workspace";
            }
        ];

        #--- AUTOSTART ---#
        on = {
            _args = [
                "hyprland.start"
                (lib.generators.mkLuaInline ''
                    function()
                        hl.exec_cmd("hyprpaper")
                    end
                '')
            ];
        };

        #--- SMART GAPS ---#
        # workspace_rule = [
        #     {
        #         workspace = "f[1]";
        #         gaps_out = 0;
        #         gaps_in = 0;
        #     }
        #     {
        #         workspace = "w[tv1]";
        #         gaps_out = 0;
        #         gaps_in = 0;
        #     }
        # ];
        #
        # window_rule = [
        #     {
        #         match.float = false;
        #         match.workspace = "f[1]";
        #         border_size = 0;
        #         rounding = 0;
        #     }
        #     {
        #         match.float = false;
        #         match.workspace = "w[tv1]";
        #         border_size = 0;
        #         rounding = 0;
        #     }
        # ];

        #--- WINDOW RULES ---#
        window_rule = [
            {
                match = {
                    class = "^vesktop$";
                };

                workspace = "special:magicS";
            }
        ];

        #--- ENVIRONMENT VARIABLES ---#
        env = [
            {
                _args = [
                    "XCURSOR_SIZE"
                    "24"
                ];
            }
            {
                _args = [
                    "HYPRCURSOR_SIZE"
                    "24"
                ];
            }
            {
                _args = [
                    "NIXOS_OZONE_WL"
                    "1"
                ];
            }
            {
                _args = [
                    "MOZ_ENABLE_WAYLAND"
                    "1"
                ];
            }
            {
                _args = [
                    "MOZ_WEBRENDER"
                    "1"
                ];
            }
            {
                _args = [
                    "GDK_BACKEND"
                    "wayland,x11,*"
                ];
            }
            {
                _args = [
                    "QT_QPA_PLATFORM"
                    "wayland;xcb"
                ];
            }
            {
                _args = [
                    "SDL_VIDEODRIVER"
                    "wayland"
                ];
            }
            {
                _args = [
                    "CLUTTER_BACKEND"
                    "wayland"
                ];
            }
            {
                _args = [
                    "XDG_CURRENT_DESKTOP"
                    "Hyprland"
                ];
            }
            {
                _args = [
                    "XDG_SESSION_TYPE"
                    "wayland"
                ];
            }
            {
                _args = [
                    "XDG_SESSION_DESKTOP"
                    "Hyprland"
                ];
            }
            {
                _args = [
                    "QT_AUTO_SCREEN_SCALE_FACTOR"
                    "1"
                ];
            }
        ]
        ++ (lib.optionals config.modules.hyprland.enableNvidia [
            {
                _args = [
                    "GBM_BACKEND"
                    "nvidia-drm"
                ];
            }
            {
                _args = [
                    "__GLX_VENDOR_LIBRARY_NAME"
                    "nvidia"
                ];
            }
            {
                _args = [
                    "LIBVA_DRIVER_NAME"
                    "nvidia"
                ];
            }
            {
                _args = [
                    "__GL_GSYNC_ALLOWED"
                    "1"
                ];
            }
        ]);

        #--- BINDS ---#
        bind = [
            (bind "CTRL + ALT + Delete" (exec "uwsm stop"))

            (bind "${mod} + Return" (exec terminal))
            (bind "${mod} + C" (exec browser))
            (bind "${mod} + Space" (exec launcher))
            (bind "CTRL + ${mod} + Space" (exec runner))
            (bind "Print" (exec screenshot))

            (bind "CTRL + SUPER + left" "hl.dsp.workspace.move({ monitor = '-1' })")
            (bind "CTRL + SUPER + right" "hl.dsp.workspace.move({ monitor = '+1' })")

			(bind "SUPER + left" "hl.dsp.layout('focus l')")
			(bind "SUPER + right" "hl.dsp.layout('focus r')")
			(bind "SUPER + up" "hl.dsp.layout('expel')")
			(bind "SUPER + down" "hl.dsp.layout('consume_or_expel prev')")
			(bind "SUPER + SHIFT + left" "hl.dsp.layout('swapcol l')")
			(bind "SUPER + SHIFT + right" "hl.dsp.layout('swapcol r')")

            (bind "${mod} + Q" "hl.dsp.window.close()")
            (bind "${mod} + F" "hl.dsp.window.fullscreen()")
            (bind "${mod} + Z" "hl.dsp.window.float({ action = \"toggle\"})")

            (bind "${mod} + mouse_down" "hl.dsp.focus({ workspace = 'e+1' })")
            (bind "${mod} + mouse_up" "hl.dsp.focus({ workspace = 'e-1' })")
            (bind3 "${mod} + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
            (bind3 "${mod} + mouse:273" "hl.dsp.window.resize()" { mouse = true; })

            (bind3 "XF86AudioRaiseVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") {
                locked = true;
                repeating = true;
            })
            (bind3 "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") {
                locked = true;
                repeating = true;
            })
            (bind3 "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
                locked = true;
                repeating = true;
            })
            (bind3 "XF86AudioMicMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") {
                locked = true;
                repeating = true;
            })
            (bind3 "XF86MonBrightnessUp" (exec "brightnessctl set 10%+") {
                locked = true;
                repeating = true;
            })
            (bind3 "XF86MonBrightnessDown" (exec "brightnessctl set 10%-") {
                locked = true;
                repeating = true;
            })
            (bind "XF86AudioNext" (exec "playerctl next"))
            (bind "XF86AudioPause" (exec "playerctl play-pause"))
            (bind "XF86AudioPlay" (exec "playerctl play-pause"))
            (bind "XF86AudioPrev" (exec "playerctl previous"))
        ]
        ++ (lib.lists.concatMap (
            id:
            let
                key = if id >= 10 then id - 10 else id; # Map 10 to 0
            in
            [
                (bind "${mod} + ${toString key}" "hl.dsp.focus({ workspace = ${toString id} })")
                (bind "${mod} + SHIFT + ${toString key}" "hl.dsp.window.move({ workspace = ${toString id}})")
            ]
        ) (lib.lists.range 1 10))
        ++ (lib.lists.concatMap
            (key: [
                (bind "${mod} + ${key}" "hl.dsp.workspace.toggle_special('magic${key}')")
                (bind "${mod} + SHIFT + ${key}" "hl.dsp.window.move({ workspace = 'special:magic${key}' })")
            ])
            [
                "A"
                "S"
                "D"
            ]
        );
    };
}
