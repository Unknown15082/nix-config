{ lib, config, inputs, ... }:
let
	cfg = config.modules.sound;
in
{
	imports = [
		inputs.nix-gaming.nixosModules.pipewireLowLatency
	];

	options.modules.sound = {
		enable = lib.mkEnableOption "PipeWire sound server";
	};

	config = lib.mkIf cfg.enable {
		# Disable pulseaudio
		services.pulseaudio.enable = false;

		# Enable rtkit
		security.rtkit.enable = true;

		# Enable pipewire
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
