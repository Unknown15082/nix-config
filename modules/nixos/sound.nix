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

		pulse.enable = true;

		jack.enable = true;
	};

	# Enable extra codecs for Bluetooth
	services.pipewire.wireplumber.extraConfig = {
		"monitor.bluez.properties" = {
			"bluez5.enable-sbc-xq" = true;
			"bluez5.enable-msbc" = true;
			"bluez5.enable-hw-volume" = true;
			"bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
		};
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
