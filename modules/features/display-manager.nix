{ self, ... }: {
	flake.modules.nixos.sddm = { pkgs, ... }: {
		services.displayManager.sddm = {
			enable = true;
			wayland.enable = true;
			package = pkgs.kdePackages.sddm;

			settings.General.InputMethod = "qtvirtualkeyboard";

			extraPackages = (with pkgs.kdePackages; [
				qtsvg
				qtmultimedia
				qtvirtualkeyboard
				qtdeclarative
			]) ++ (with pkgs.gst_all_1; [
				gstreamer
				gst-plugins-base
				gst-plugins-good
				gst-plugins-bad
				gst-libav
			]);
		};

		systemd.services.display-manager.environment = {
			QT_IM_MODULE = "qtvirtualkeyboard";
			QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = "1";
		};
	};

	flake.modules.nixos.sddmTheme = { pkgs, ... }: {
		environment.systemPackages = [
			(pkgs.sddm-astronaut.override {
				embeddedTheme = "pixel_sakura";
				themeConfig = {
					DateFormat = "dddd, yyyy-MM-dd";
				};
			})
		];

		services.displayManager.sddm.theme = "sddm-astronaut-theme";
	};

	flake.modules.nixos.sddmGnomeKeyring = {
		security.pam.services.sddm.enableGnomeKeyring = true;
	};

	flake.modules.nixos.gnomeKeyring = { pkgs, config, ... }: {
		imports = [
			self.modules.nixos.sddmGnomeKeyring
		];

		home-manager.sharedModules = [
			self.modules.homeManager.gnomeKeyring
		];

		services.gnome.gnome-keyring.enable = true;
		environment.systemPackages = [ pkgs.libsecret ];
		services.dbus.packages = [ pkgs.seahorse ];
		programs.seahorse.enable = true;

		environment.sessionVariables = let
			uid = config.users.users.${config.settings.primaryUser}.uid;
		in {
			SSH_AUTH_SOCK = "/run/user/${toString uid}/keyring/ssh";
		};
	};

	flake.modules.homeManager.gnomeKeyring = { pkgs, ... }: {
		services.gnome-keyring = {
			enable = true;
			components = [
				"pkcs11"
				"secrets"
				"ssh"
			];
		};

		home.packages = [ pkgs.seahorse ];
	};
}
