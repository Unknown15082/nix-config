{ self, inputs, ... }: {
	flake.modules.nixos.hyprland = { pkgs, ... }: {
		imports = with self.modules.nixos; [
			hyprlandPortal
			hyprlandPolkit
			hyprlock
		];

		home-manager.sharedModules = [
			self.modules.homeManager.hyprland
		];

		programs.hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		};

		settings.binaryCaches.caches = [
			{
				url = "https://hyprland.cachix.org";
				key = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
			}
		];
	};

	flake.modules.homeManager.hyprlandAutoStart = { lib, config, ... }: {
		options.settings.hyprland = {
			autoStart = with lib; mkOption {
				type = types.listOf types.str;
				description = "List of packages to auto-start";
			};
		};

		config = let
			autoStartList = config.settings.hyprland.autoStart;
			autoStartCmds = builtins.concatStringsSep "\n" (builtins.map (cmd: "hl.exec_cmd('${cmd}')") autoStartList);
		in {
			wayland.windowManager.hyprland.settings = {
				on = {
					_args = [
						"hyprland.start"
						(lib.generators.mkLuaInline ''
							function()
								${autoStartCmds}
							end
						'')
					];
				};
			};
		};
	};

	flake.modules.nixos.hyprlandPortal = { pkgs, ... }: {
		programs.hyprland = {
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
		};

		xdg.portal = {
			enable = true;
			extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
		};

	};

	flake.modules.nixos.hyprlandPolkit = { pkgs, ... }: {
		security.polkit.enable = true;
		environment.systemPackages = [ pkgs.hyprpolkitagent ];
	};

	flake.modules.homeManager.hyprland = {
		imports = with self.modules.homeManager; [
			hyprlandAutoStart
			hyprlandSettings
			hypridle
			hyprpaper
			mako
			rofi
			waybar
		];

		wayland.windowManager.hyprland = {
			enable = true;
			package = null;
			portalPackage = null;

			configType = "lua";

			systemd = {
				enable = true;
				variables = [ "--all" ];
			};
		};
	};
}
