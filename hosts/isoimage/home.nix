{ username, utils, ... }:
{
	home.username = "${username}";
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	home.file."README.md" = {
		source = utils.relativeToRoot "configs/isoimage/README.md";
	};

	home.file."justfile" = {
		source = utils.relativeToRoot "configs/isoimage/justfile";
	};
}
