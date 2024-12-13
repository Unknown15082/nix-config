{ pkgs, lib, config, ... }:
with pkgs.python3Packages;
let
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

	cfg = config.modules.bluetooth;

	bt-sync = pkgs.writeShellScriptBin "bt-sync" ''
		mount --mkdir /dev/${cfg.bt-sync.windows_partition} /mnt/win
		${bt-dualboot}/bin/bt-dualboot --win /mnt/win --sync-all --no-backup
		umount -R /mnt/win
	'';
in
{
	options.modules.bluetooth.bt-sync = {
		enable = lib.mkEnableOption "Bluetooth dualboot script" // { default = cfg.enable; };

		windows_partition = lib.mkOption {
			type = lib.types.str;
			description = "The partition of Windows' C: drive";
		};
	};

	config = lib.mkIf cfg.bt-sync.enable {
		environment.systemPackages = with pkgs; [
			chntpw
			bt-dualboot
			bt-sync
		];
	};
}
