{ ... }: {
    flake.modules.homeManager.rofi =
        {
            config,
            lib,
            pkgs,
            ...
        }:
        {
            programs.rofi = {
                enable = true;
                # TODO: Use central settings value for terminal detection
                terminal = lib.getExe pkgs.ghostty;

                theme =
                    let
                        inherit (config.lib.formats.rasi) mkLiteral;

                        mkColor = color: mkLiteral "@${color}";
                        mkPixel = length: mkLiteral "${toString length}px";
                        mkPixel4 =
                            l1: l2: l3: l4:
                            mkLiteral "${toString l1}px ${toString l2}px ${toString l3}px ${toString l4}px";
                    in
                    {
                        configuration = {
                            show-icons = true;
                            display-drun = "";
                            window-title = "";
                            drun-display-format = "{icon} {name}";
                            disable-history = false;
                            click-to-exit = true;
                            location = 0;
                        };

                        "*" = {
                            font = "JetBrainsMono Nerd Font Mono 10";

                            BG = mkLiteral "#1E1D2Fff";
                            BGA = mkLiteral "#89DCEBff";
                            FG = mkLiteral "#D9E0EEff";
                            FGA = mkLiteral "#F28FADff";
                            BDR = mkLiteral "#96CDFBff";
                            SEL = mkLiteral "#1E1E2Eff";
                            UGT = mkLiteral "#F28FADff";
                            IMG = mkLiteral "#FAE3B0ff";
                            OFF = mkLiteral "#575268ff";
                            ON = mkLiteral "#ABE9B3ff";
                        };

                        window = {
                            transparency = "real";
                            background-color = mkColor "BG";
                            text-color = mkColor "FG";
                            border = mkPixel 2;
                            border-color = mkColor "BDR";
                            border-radius = mkPixel 10;
                            width = mkPixel 500;
                            anchor = mkLiteral "center";
                            x-offset = 0;
                            y-offset = 0;
                        };

                        prompt = {
                            enabled = true;
                            padding = mkPixel 8;
                            background-color = mkColor "BG";
                            text-color = mkColor "IMG";
                        };

                        textbox-prompt-colon = {
                            expand = false;
                            str = "";
                            border-radius = mkLiteral "100%";
                            background-color = mkColor "SEL";
                            text-color = mkColor "FG";
                            padding = mkPixel4 8 12 8 12;
                            font = "JetBrainsMono Nerd Font Mono 10";
                        };

                        entry = {
                            background-color = mkColor "BG";
                            text-color = mkColor "FG";
                            placeholder-color = mkColor "FG";
                            expand = true;
                            horizontal-align = 0;
                            placeholder = "Search...";
                            blink = true;
                            border = mkPixel4 0 0 2 0;
                            border-color = mkColor "BDR";
                            border-radius = mkPixel 10;
                            padding = mkPixel 8;
                        };

                        inputbar = {
                            children = [
                                (mkLiteral "textbox-prompt-colon")
                                (mkLiteral "prompt")
                                (mkLiteral "entry")
                            ];
                            background-color = mkColor "BG";
                            text-color = mkColor "FG";
                            expand = false;
                            border = mkPixel4 0 0 0 0;
                            border-radius = mkPixel 0;
                            border-color = mkColor "BDR";
                            margin = mkPixel4 0 0 0 0;
                            padding = mkPixel 0;
                            position = mkLiteral "center";
                        };

                        case-indicator = {
                            background-color = mkColor "BG";
                            text-color = mkColor "FG";
                            spacing = 0;
                        };

                        listview = {
                            background-color = mkColor "BG";
                            columns = 1;
                            lines = 7;
                            spacing = mkPixel 4;
                            cycle = false;
                            dynamic = true;
                            layout = mkLiteral "vertical";
                        };

                        mainbox = {
                            background-color = mkColor "BG";
                            children = [
                                (mkLiteral "inputbar")
                                (mkLiteral "listview")
                            ];

                            spacing = mkPixel 15;
                            padding = mkPixel 15;
                        };

                        element = {
                            background-color = mkColor "BG";
                            text-color = mkColor "FG";
                            orientation = mkLiteral "horizontal";
                            border-radius = mkPixel 4;
                            padding = mkPixel4 6 6 6 6;
                        };

                        element-icon = {
                            background-color = mkLiteral "inherit";
                            text-color = mkLiteral "inherit";
                            horizontal-align = mkLiteral "0.5";
                            vertical-align = mkLiteral "0.5";
                            size = mkPixel 24;
                            border = mkPixel 0;
                        };

                        element-text = {
                            background-color = mkLiteral "inherit";
                            text-color = mkLiteral "inherit";
                            expand = true;
                            horizontal-align = 0;
                            vertical-align = mkLiteral "0.5";
                            margin = mkPixel4 2 0 2 2;
                        };

                        "element normal.urgent" = {
                            background-color = mkColor "UGT";
                            text-color = mkColor "FG";
                            border-radius = mkPixel 9;
                        };

                        "element alternate.urgent" = {
                            background-color = mkColor "UGT";
                            text-color = mkColor "FG";
                            border-radius = mkPixel 9;
                        };

                        "element normal.active" = {
                            background-color = mkColor "BGA";
                            text-color = mkColor "FG";
                        };

                        "element alternate.active" = {
                            background-color = mkColor "BGA";
                            text-color = mkColor "FG";
                        };

                        "element selected" = {
                            background-color = mkColor "BGA";
                            text-color = mkColor "SEL";
                            border = mkPixel4 0 0 0 0;
                            border-radius = mkPixel 10;
                            border-color = mkColor "BDR";
                        };

                        "element selected.urgent" = {
                            background-color = mkColor "UGT";
                            text-color = mkColor "FG";
                        };

                        "element selected.active" = {
                            background-color = mkColor "BGA";
                            text-color = mkColor "FG";
                        };
                    };
            };
        };
}
