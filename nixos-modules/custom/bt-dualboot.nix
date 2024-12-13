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

	bt-sync = pkgs.writeShellScriptBin "bt-sync" ''
		${bt-dualboot}/bin/bt-dualboot --sync-all --no-backup
	'';
in
{
	config = lib.mkIf config.modules.bluetooth.enable {
		environment.systemPackages = with pkgs; [
			chntpw
			bt-dualboot
			bt-sync
		];
	};
}
