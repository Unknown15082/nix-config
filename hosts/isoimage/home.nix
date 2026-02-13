{ username, libutils, ... }:
{
	home.username = "${username}";
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	home.file."README.md" = {
		source = libutils.relativeToRoot "configs/isoimage/README.md";
	};

	home.file."justfile" = {
		source = libutils.relativeToRoot "configs/isoimage/justfile";
	};
}
