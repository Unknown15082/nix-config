{ lib, config, pkgs, ... }:
let
	cfg = config.modules.selfhost;
in {
	options.modules.selfhost = {
		enable = lib.mkEnableOption "selfhosting softwares";

		domainName = lib.mkOption {
			description = "The default domain name used";
			type = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		services.caddy = {
			enable = true;
			package = pkgs.caddy.withPlugins {
				plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" "github.com/greenpau/caddy-security@v1.1.31" ];
				hash = "sha256-CI6bQUeySG7bRN+phU8v9fh3I+IVm04FoT2aJG4IpGA=";
			};

			environmentFile = config.age.secrets.caddy_env.path;
			globalConfig = ''
				acme_dns cloudflare {env.CF_API_TOKEN}

				order authenticate before respond
				order authorize before basicauth

				security {
					oauth identity provider discord {
						realm discord
						driver discord
						client_id {env.DISCORD_CLIENT_ID}
						client_secret {env.DISCORD_CLIENT_SECRET}
						scopes identify email guilds guilds.members.read
						user_group_filters {env.DISCORD_GUILD_ID}
					}

					authentication portal authportal {
						crypto default token lifetime 3600
						
						cookie domain ${cfg.domainName}

						enable identity provider discord

						transform user {
							match realm discord
							match sub discord.com/{env.DISCORD_USER_ID}
							action add role authp/admin
						}

						transform user {
							match realm discord
							match role discord.com/{env.DISCORD_GUILD_ID}/members
							action add role authp/user
						}
					}

					authorization policy authpolicy {
						set auth url https://auth.${cfg.domainName}/auth/oauth2/discord
						allow roles authp/admin authp/user
						validate bearer header
						inject headers with claims
					}
				}
			'';
			virtualHosts."auth.${cfg.domainName}".extraConfig = ''
				authenticate with authportal
			'';
		};

		networking.firewall = {
			allowedTCPPorts = [ 80 443 ];
		};

		virtualisation.oci-containers.backend = "podman";
	};
}
