{ lib, config, ... }:
let
    cfg = config.modules.ghostty;
    stylixCfg = config.stylix;
in
{
    options.modules.ghostty = {
        enable = lib.mkEnableOption "Ghostty";
    };

    config = lib.mkIf cfg.enable {
        programs.ghostty = {
            enable = true;
            enableFishIntegration = true;
            installBatSyntax = true;

            settings = {
                # Disable emoji fonts
                font-family = lib.mkForce [
                    stylixCfg.fonts.monospace.name
                ];

                # Disable ligatures
                font-feature = [
                    "-calt"
                    "-liga"
                    "-dlig"
                ];

                # Disable cursor blink
                cursor-style = "bar";
                cursor-style-blink = false;

                # Disable mouse while typing
                mouse-hide-while-typing = true;

                # Disable the resize overlay
                resize-overlay = "never";

                # Allow clipboard usage
                clipboard-read = "allow";
                clipboard-write = "allow";

                # Shell integrations
                shell-integration-features = "no-cursor,sudo,title,ssh-env";
            };
        };
    };
}
