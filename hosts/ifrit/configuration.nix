{ pkgs, utils, ... }:
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
		btop

		dive
		podman-tui
		podman-compose
	];
	services.do-agent.enable = true;

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
				environmentFiles = [
					"/etc/otterwiki/.env"
				];
			};
			paperless = {
				enable = true;
				port = 7002;
			};
			stirling-pdf = {
				enable = true;
				port = 7003;
			};
		};
	};

	system.stateVersion = "23.11";
}
