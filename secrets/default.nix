{ inputs, username, ... }:
let
	secrets = inputs.secrets;
in
{
	imports = [
		inputs.agenix.nixosModules.default
	];

	age.identityPaths = [
		"/etc/ssh/ssh_host_ed25519_key"
		"/home/${username}/.ssh/id_ed25519"
	];

	age.secrets = {
		cloudflare_token = {
			file = "${secrets}/cloudflare_token.age";
		};
	};
}
