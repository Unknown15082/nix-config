{ pkgs, ... }:
{
	imports = [
		./hardware-configuration.nix
		./disko-config.nix
	];

	nixpkgs.hostPlatform = "x86_64-linux";
	nix.settings.experimental-features = [
		"nix-command" "flakes"
	];

	system.stateVersion = "25.05";

	boot.loader.grub.enable = true;

	networking.hostName = "scylla";
	services.openssh.enable = true;
	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILeIOQzu+mY5V0Gll45muIwqjACIOdqNP2JuE5G8vyYM"
	];

	environment.systemPackages = with pkgs; [
		neovim
		git
		btop

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

	# Domain Name
	modules.selfhost = {
		enable = true;
		domainName = "huytrangia.dev";
		services = {
			index.enable = true;
			test.enable = true;
			otterwiki = {
				enable = true;
				port = 7001;
			};
			paperless = {
				enable = true;
				port = 7002;
			};
			stirling-pdf = {
				enable = true;
				port = 7003;
			};
			headscale = {
				enable = true;
				port = 7004;
				headplane = {
					enable = true;
					port = 7005;
				};
			};
		};
	};
}
