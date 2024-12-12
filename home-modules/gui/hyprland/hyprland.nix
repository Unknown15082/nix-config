{ lib, mylib, config, osConfig, ... }:
let
	cfg = config.modules.hyprland;
in
{
	options.modules.hyprland = {
		enable = lib.mkEnableOption "Hyprland" // { default = true; };
	};

	config = lib.mkIf cfg.enable {
		programs.alacritty.enable = true;
		programs.kitty.enable = true;
		programs.fuzzel.enable = true;

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
				enable = true;
				variables = [ "--all" ];
			};
		};

		xdg.configFile."hypr/original.conf" = {
			source = mylib.relativeToRoot "configs/hypr/original.conf";
		};
	};
}
