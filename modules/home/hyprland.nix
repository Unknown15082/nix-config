{ lib, config, pkgs, ... }:
let
	cfg = config.modules.hyprland;
in
{
	options.modules.hyprland = {
		enable = lib.mkEnableOption "Hyprland";
	};

	config = lib.mkIf cfg.enable {
		programs.alacritty.enable = true;
		programs.kitty.enable = true;
		programs.fuzzel.enable = true;

		wayland.windowManager.hyprland = {
			enable = true;
			extraConfig = builtins.readFile ../../configs/hypr/hyprland.conf;

			settings = {
				env = [
					"NIXOS_OZONE_WL,1"
					"MOZ_ENABLE_WAYLAND,1"
					"MOZ_WEBRENDER,1"
				];
			};

			systemd = {
				enable = true;
				variables = [ "--all" ];
			};
		};

		xdg.configFile."hypr/original.conf" = {
			source = ../../configs/hypr/original.conf;
		};
	};
}
