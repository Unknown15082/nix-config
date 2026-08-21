{ self, ... }: {
	flake.modules.nixos.hyprlock = {
		security.pam.services.hyprlock = {};

		home-manager.sharedModules = [
			self.modules.homeManager.hyprlock
		];
	};

	flake.modules.homeManager.hyprlock = {
		programs.hyprlock = {
			enable = true;
			settings = {};
		};
	};

	flake.modules.homeManager.hypridle = { pkgs, lib, ... }: let
		brightnessctl = lib.getExe pkgs.brightnessctl;
	in {
		services.hypridle = {
			enable = true;
			settings = {
				general = {
					lock_cmd = "pidof hyprlock || hyprlock";
					before_sleep_cmd = "loginctl lock-session";
					after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
				};

				listener = [
					{
						timeout = 150;
						on-timeout = "${brightnessctl} -s set 10";
						on-resume = "${brightnessctl} -r";
					}
					{
						timeout = 300;
						on-timeout = "loginctl lock-session";
					}
					{
						timeout = 330;
						on-timeout = "hyprctl dispatch 'hl.dsp.dms({ action = \"disable\" })'";
						on-resume = "hyprctl dispatch 'hl.dsp.dms({ action = \"enable\" })' && ${brightnessctl} -r";
					}
				];
			};
		};
	};

	flake.modules.homeManager.hyprpaper = {
		services.hyprpaper = {
			enable = true;
			settings = {
				splash = false;
				wallpaper = [
					{
						monitor = "";
						path = "${self}/assets/wallpapers";
						timeout = 60;
					}
				];
			};
		};

		settings.hyprland.autoStart = [ "hyprpaper" ];

		wayland.windowManager.hyprland.settings = {
			layer_rule = [
				{
					name = "wallpaper-fade";
					match = { namespace = "^hyprpaper$"; };
					animation = "fade";
				}
			];
		};
	};

	flake.modules.homeManager.mako = {
		services.mako = {
			enable = true;
			settings = {
				layer = "overlay";
				default-timeout = 10000; # 10000ms = 10s
			};
		};
	};
}
