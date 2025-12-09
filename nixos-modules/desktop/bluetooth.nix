{ lib, config, pkgs, ... }:
with pkgs.python3Packages;
let
	cfg = config.modules.bluetooth;

	bt-dualboot = buildPythonApplication rec {
		pname = "bt-dualboot";
		version = "1.0.1";
		pyproject = true;

		src = pkgs.fetchPypi {
			inherit pname version;
			sha256 = "sha256-pjzGvLkotQllzyrnxqDIjGlpBOvUPkWpv0eooCUrgv8=";
		};

		dependencies = [
			poetry-core
		];

		meta = with lib; {
			homepage = "https://pypi.org/project/bt-dualboot/";
			description = "Sync Bluetooth for dualboot Linux and Windows";
			license = licenses.mit;
		};
	};

	bt-sync = pkgs.writeShellScriptBin "bt-sync" ''
		mount --mkdir /dev/${cfg.bt-sync.windows_partition} /mnt/win
		${bt-dualboot}/bin/bt-dualboot --win /mnt/win --sync-all --no-backup
		umount -R /mnt/win
	'';
in
{
	options.modules.bluetooth = {
		enable = lib.mkEnableOption "Bluetooth";

		bt-sync = {
			enable = lib.mkEnableOption "Bluetooth dualboot script" // { default = cfg.enable; };

			windows_partition = lib.mkOption {
				type = lib.types.str;
				description = "Windows' C: partition location";
			};
		};
	};

	config = lib.mkIf cfg.enable {
		# Enable Bluetooth
		hardware.bluetooth.enable = true;
		hardware.bluetooth.powerOnBoot = true;

		# Enable Blueman,
		# which provides blueman-applet and blueman-manager
		services.blueman.enable = true;

		# TODO: Check for pipewire/wireplumber
		# Enable extra codecs for Bluetooth
		services.pipewire.wireplumber.extraConfig = {
			"monitor.bluez.properties" = {
				"bluez5.enable-sbc-xq" = true;
				"bluez5.enable-msbc" = true;
				"bluez5.enable-hw-volume" = true;
				"bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
			};
		};

		# Enable experimental features (Battery charge)
		hardware.bluetooth.settings.General.Experimental = true;

		# Bluetooth dualboot script
		environment.systemPackages = lib.mkIf cfg.bt-sync.enable [
			pkgs.chntpw
			bt-dualboot
			bt-sync
		];
	};
}
