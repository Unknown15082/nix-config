{ self, ... }: {
	flake.modules.nixos.presets-base = {
		imports = with self.modules.nixos; [
			kernel
			systemd-boot
			networkManager
			openssh
			agenix

			nixSettings
			locale
			timezone
			allFonts
			fish
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

			protonvpn
		];
	};
}
