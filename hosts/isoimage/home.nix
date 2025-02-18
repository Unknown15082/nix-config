{ username, mylib, ... }:
{
	home.username = "${username}";
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "23.11";
	programs.home-manager.enable = true;

	home.file."README.md" = {
		source = mylib.relativeToRoot "configs/isoimage/README.md";
	};

	home.file."justfile" = {
		source = mylib.relativeToRoot "configs/isoimage/justfile";
	};
}
