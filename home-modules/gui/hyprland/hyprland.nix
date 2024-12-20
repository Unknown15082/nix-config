{ lib, mylib, config, osConfig, pkgs, ... }:
let
	cfg = config.modules.hyprland;
in
{
	options.modules.hyprland = {
		enable = mylib.mkEnableTrueOption "Hyprland";
	};

	config = lib.mkIf cfg.enable {
		programs.fuzzel = {
			enable = true;
			settings = {
				main.font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.popups}";
				border.width = 3;
			};
		};

		home.packages = with pkgs; [ hyprpaper ];

		wayland.windowManager.hyprland = {
			enable = true;
			extraConfig = builtins.readFile (mylib.relativeToRoot "configs/hypr/hyprland.conf");

			settings = {
				env = [
					"NIXOS_OZONE_WL,1"
					"MOZ_ENABLE_WAYLAND,1"
					"MOZ_WEBRENDER,1"

					"GDK_BACKEND,wayland,x11,*"
					"QT_QPA_PLATFORM,wayland;xcb"
					"SDL_VIDEODRIVER,wayland"
					"CLUTTER_BACKEND,wayland"

					"XDG_CURRENT_DESKTOP,Hyprland"
					"XDG_SESSION_TYPE,wayland"
					"XDG_SESSION_DESKTOP,Hyprland"

					"QT_AUTO_SCREEN_SCALE_FACTOR,1"
					"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
				] ++ (
					lib.optionals 
						osConfig.modules.nvidia.enable
						[
							"GBM_BACKEND,nvidia-drm"
							"__GLX_VENDOR_LIBRARY_NAME,nvidia"
							"LIBVA_DRIVER_NAME,nvidia"
						]
				);
			};

			systemd = {
				enable = !osConfig.programs.hyprland.withUWSM;
				variables = [ "--all" ];
			};
		};

		xdg.configFile."hypr/original.conf" = {
			source = mylib.relativeToRoot "configs/hypr/original.conf";
		};
	};
}
