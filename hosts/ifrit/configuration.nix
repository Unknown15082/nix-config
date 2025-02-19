{ pkgs, lib, ... }:
{
	imports = [
		./hardware-configuration.nix
		./networking.nix
	];

	nixpkgs.hostPlatform = "x86_64-linux";
	nix.settings.experimental-features = [
		"nix-command" "flakes"
	];

	boot.tmp.cleanOnBoot = true;
	zramSwap.enable = true;
	networking.hostName = "ifrit";
	networking.domain = "";
	services.openssh.enable = true;
	users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILeIOQzu+mY5V0Gll45muIwqjACIOdqNP2JuE5G8vyYM'' ];

	environment.systemPackages = with pkgs; [
		neovim
		git

		dive
		podman-tui
		podman-compose
	];

	virtualisation.containers.enable = true;
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
		defaultNetwork.settings.dns_enabled = true;
	};

	system.stateVersion = "23.11";
}
