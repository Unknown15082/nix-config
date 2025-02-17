{ pkgs, modulesPath, system, inputs, ... }: {
	imports = [
		"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
	];

	# ISO file setup
	isoImage = {
		edition = "custom";
		makeEfiBootable = true;
		makeUsbBootable = true;
		squashfsCompression = "gzip -Xcompression-level 1";
	};
	

	# Nix setup
	nixpkgs.hostPlatform = "x86_64-linux";
	nix.settings.experimental-features = [
		"nix-command" "flakes"
	];

	# SSH
	services.openssh.enable = true;
	systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPZG7cZYt6YbE1/sQsAXGKpK22+CIOBe8L6LTZwYCSR .iso-only SSH key"
	];
	security.sudo.wheelNeedsPassword = false;

	# Additional packages
	environment.systemPackages = with pkgs; [
		# Custom neovim
		inputs.nixvim-config.packages.${system}.default

		git
		gparted
	];
}
