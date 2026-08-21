{ ... }: {
	flake.modules.nixos.systemd-boot = { lib, config, ... }: {
		options.settings.systemd-boot = {
			windows = with lib; mkOption {
				type = types.nullOr types.str;
				default = null;
				description = ''
					The device handle for Windows EFI partition.
					Obtained from: https://search.nixos.org/options?channel=unstable&query=systemd-boot&type=options
				'';
			};
		};

		config = let
			cfg = config.settings.systemd-boot;
		in {
			boot.loader = {
				efi.canTouchEfiVariables = true;
				timeout = 60;

				systemd-boot = {
					enable = true;
					configurationLimit = 10;

					edk2-uefi-shell.enable = true;
					memtest86.enable = true;

					bootCounting.enable = true;
					bootCounting.tries = 3;

					consoleMode = "max";

					windows."11" = lib.mkIf (cfg.windows != null) {
						title = "Windows 11";
						sortKey = "a_windows";
						efiDeviceHandle = cfg.windows;
					};
				};
			};
		};
	};
}
