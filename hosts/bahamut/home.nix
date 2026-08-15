{
	inputs,
	config,
	pkgs,
	username,
	system,
	...
}:
{
	home.username = "${username}";
	home.homeDirectory = "/home/${username}";

	home.stateVersion = "26.05";
	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		firefox

		inputs.nixvim-config.packages.${system}.default
	];

	programs.git = {
		enable = true;

		settings = {
			user.name = "Unknown15082";
			user.email = "trangiahuy15082006@gmail.com";
		};
	};

	modules.discord.enable = true;
	modules.discord.addons = true;

	modules.ghostty.enable = true;
	modules.shell-utils.enable = true;
}
