{ self, ... }: {
	flake.modules.nixos.presets-base = {
		imports = with self.modules.nixos; [
			kernel
			systemd-boot
			networkManager

			nixSettings
			locale
			timezone
			allFonts
		];
	};

	flake.modules.nixos.presets-desktop = {
		imports = with self.modules.nixos; [
			presets-base

			hyprland

			audio
			bluetooth
			catppuccin
			keyd

			sddm
			sddmTheme
		];
	};
}
