{ pkgs, lib, ... }:
with pkgs.python3Packages;
let
	pulse-cookie = buildPythonApplication rec {
		pname = "pulse-cookie";
		version = "1.0";
		pyproject = true;

		src = pkgs.fetchPypi {
			inherit pname version;
			sha256 = "sha256-ZURSXfChq2k8ktKO6nc6AuVaAMS3eOcFkiKahpq4ebU=";
		};

		dependencies = [
			setuptools
			setuptools-scm
			pyqt6-webengine
		];

		meta = with lib; {
			homepage = "https://pypi.org/project/pulse-cookie/";
			description = "Minimal QtWebEngine-based Web UI to extract the Pulse Connect Secure authentication cookie for use with OpenConnect VPN";
			license = licenses.gpl3;
		};
	};

	pulse-vpn = pkgs.writeShellScriptBin "pulse-vpn" ''
		HOST=$1
		DSID=$(${pulse-cookie}/bin/get-pulse-cookie -n DSID $HOST)
		sudo ${pkgs.openconnect}/bin/openconnect --protocol nc -C DSID=$DSID $HOST
	'';
in
{
	environment.systemPackages = with pkgs; [
		openconnect
		pulse-vpn	
	];
}
