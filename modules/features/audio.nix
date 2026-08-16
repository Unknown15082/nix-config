{ inputs, ... }: {
	flake.modules.nixos.audio = {
		imports = [
			inputs.nix-gaming.nixosModules.pipewireLowLatency
		];

		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			wireplumber.enable = true;
			pulse.enable = true;
			jack.enable = true;

			lowLatency = {
				enable = true;
				quantum = 64;
				rate = 48000;
			};
		};
	};
}
