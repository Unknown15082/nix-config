{
	# Enable Bluetooth
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	# Enable extra codecs for Bluetooth
	services.pipewire.wireplumber.extraConfig = {
		"monitor.bluez.properties" = {
			"bluez5.enable-sbc-xq" = true;
			"bluez5.enable-msbc" = true;
			"bluez5.enable-hw-volume" = true;
			"bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
		};
	};

	# Enable experimental features (Battery charge)
	hardware.bluetooth.settings.General.Experimental = true;
}

