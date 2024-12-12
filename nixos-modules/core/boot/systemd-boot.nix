{ lib, config, ... }:
let
	cfg = config.modules.systemd-boot;
in
{
	options.modules.systemd-boot = {
		enable = lib.mkEnableOption "systemd-boot";
		limit = lib.mkOption {
			type = lib.types.int;
			default = 7;
			description = "The maximum number of boot configurations";
		};

		windows_dual_boot = lib.mkOption {
			type = lib.types.nullOr lib.types.str;
			default = null;
			description = "The device handle for Windows EFI partition";
		};
	};

	config = lib.mkIf cfg.enable {
		boot.loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot = {
				enable = true;
				configurationLimit = cfg.limit;

				edk2-uefi-shell.enable = true;

				windows."windows" = lib.mkIf (cfg.windows_dual_boot != null) {
					title = "Windows 11";
					sortKey = "a_windows";
					efiDeviceHandle = cfg.windows_dual_boot;
				};
			};
		};
	};
}
