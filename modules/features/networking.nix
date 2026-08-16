{ pkgs, ... }: {
	flake.modules.nixos.networkManager = {
		networking.networkmanager = {
			enable = true;

			plugins = with pkgs; [
				networkmanager-openvpn
			];

			# TODO: Add networkmanager to user's groups
		};
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
