{ pkgs, mylib, ... }:
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

	# Enable Caddy
	services.caddy = {
		enable = true;
		package = pkgs.caddy.withPlugins {
			plugins = [ "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e" ];
			hash = "sha256-JVkUkDKdat4aALJHQCq1zorJivVCdyBT+7UhqTvaFLw=";
		};
		environmentFile = "/etc/secrets/caddy.env"; # TODO: Move to agenix later
		globalConfig = ''
			acme_dns cloudflare {$CF_API_TOKEN}
		'';
		extraConfig = builtins.readFile (mylib.relativeToRoot "configs/ifrit/Caddyfile");
	};
	networking.firewall.allowedTCPPorts = [ 80 443 ];
	networking.firewall.allowedUDPPorts = [ 80 443 ];

	system.stateVersion = "23.11";
}
