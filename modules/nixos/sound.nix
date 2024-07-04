{ lib, config, ... }:
let
	cfg = config.modules.sound;
in
{
	options = {
		modules.sound = {
			enable = lib.mkEnableOption "Enable PipeWire sound server";
			low-latency = {
				enable = lib.mkEnableOption "Enable PipeWire's low-latency setup";
				quant = lib.mkOption {
					type = lib.types.int;
					default = 32;
					description = "The quant value for PipeWire (see https://nixos.wiki/wiki/PipeWire#Low-latency_setup)";
				};
			};
		};
	};

	config = lib.mkIf cfg.enable {
		# Disable sound.enable, as it is only used for ALSA
		sound.enable = false;

		# Disable pulseaudio
		hardware.pulseaudio.enable = false;

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
		};

		# Low-latency setup
		services.pipewire.extraConfig.pipewire."92-low-latency" = lib.mkIf cfg.low-latency.enable {
		  context.properties = {
			default.clock.rate = 48000;
			default.clock.quantum = cfg.low-latency.quant;
			default.clock.min-quantum = cfg.low-latency.quant;
			default.clock.max-quantum = cfg.low-latency.quant;
		  };
		};
	};
}
