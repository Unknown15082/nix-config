{ self, ... }: {
	flake.modules.homeManager.hyprcursor = { pkgs, ... }: {
		home.pointerCursor = {
			enable = true;
			package = self.lib.xcursorToHyprcursor {
				inherit pkgs;
				xcursorPackage = pkgs.bibata-cursors;
				themeName = "Bibata-Modern-Ice";
			};

			name = "Bibata-Modern-Ice";
			size = 24;
			gtk.enable = true;
			x11.enable = true;
			hyprcursor.enable = true;
		};
	};
}
