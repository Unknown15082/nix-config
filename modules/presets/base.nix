{ self, ... }: {
	flake.modules.nixos.presets.base = {
		imports = with self.modules.nixos; [
			kernel
			systemd-boot
			networkManager

			nixSettings
			locale
			fonts.all
		];
	};

	flake.modules.nixos.presets.desktop = {
		imports = with self.modules.nixos; [
			presets.base

			audio
			bluetooth
			catppuccin

			sddm
			sddmTheme
		];
	};
}
