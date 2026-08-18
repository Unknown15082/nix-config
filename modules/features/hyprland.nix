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
			package = inputs.hyprland.package.${pkgs.stdenv.hostPlatform.system}.hyprland;
		};

		settings.binaryCaches.caches = [
			{
				url = "https://hyprland.cachix.org";
				key = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
			}
		];
	};

	flake.modules.nixos.hyprlandPortal = { pkgs, ... }: {
		programs.hyprland = {
			portalPackage = inputs.hyprland.package.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
			hyprlandSettings
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
