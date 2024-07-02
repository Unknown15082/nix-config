{
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
	services.pipewire.extraConfig.pipewire."92-low-latency" = {
	  context.properties = {
	    default.clock.rate = 48000;
	    default.clock.quantum = 32;
	    default.clock.min-quantum = 32;
	    default.clock.max-quantum = 32;
	  };
	};
}
