{ ... }: {
	flake.modules.homeManager.alacritty = {
		programs.alacritty = {
			enable = true;
			settings = {
				env.TERM = "xterm-256color";
			};
		};
	};

	flake.modules.homeManager.ghostty = {
		programs.ghostty = {
			enable = true;

			enableFishIntegration = true;
			installBatSyntax = true;
			systemd.enable = true;

			settings = {
				font-family = [
					"JetBrainsMono Nerd Font Mono"
				];
				font-feature = [
					"-calt"
					"-liga"
					"-dlig"
				];
				font-size = 14;

				background-opacity = 0.8;
				background = "000000";

				cursor-style = "bar";
				cursor-style-blink = false;
				mouse-hide-while-typing = true;
				resize-overlay = "never";
				clipboard-read = "allow";
				clipboard-write = "allow";

				shell-integration-features = "no-cursor,sudo,title,ssh-env";
			};
		};

		catppuccin.ghostty.enable = true;
	};
}
