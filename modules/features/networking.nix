{ self, ... }: {
	flake.modules.nixos.networkManager = { pkgs, ... }: {
		imports = [
			self.modules.nixos.userSettings
		];

		networking.networkmanager = {
			enable = true;

			plugins = with pkgs; [
				networkmanager-openvpn
			];
		};

		settings.userGroups = [ "networkmanager" ];
	};

	flake.modules.nixos.googleNameserver = {
		networking.networkmanager.insertNameservers = [
			"8.8.8.8"
			"8.8.4.4"
		];
	};

	flake.modules.nixos.cloudflareNameserver = {
		networking.networkmanager.insertNameservers = [
			"1.1.1.1"
			"1.0.0.1"
		];
	};
}
