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

	# TODO: Move each secrets to its own config
	# TODO: Set permissions

	age.secrets = {
		caddy_env = {
			file = "${secrets}/caddy_env.age";
		};

		spotify_client_id = {
			file = "${secrets}/spotify.age";
		};

		paperless_password = {
			file = "${secrets}/paperless.age";
		};
	};
}
