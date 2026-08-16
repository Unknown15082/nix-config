{ self, ... }: {
	flake.modules.nixos.bluetooth = {
		imports = [
			self.modules.nixos.bluetoothCodecs
		];

		hardware.bluetooth.enable = true;
		hardware.bluetooth.powerOnBoot = true;

		services.blueman.enable = true;

		hardware.bluetooth.settings.General.Experimental = true;
	};

	flake.modules.nixos.bluetoothCodecs = { lib, config, ... }: {
		services.pipewire.wireplumber.extraConfig =
			lib.mkIf (config.services.pipewire.enable && config.services.pipewire.wireplumber.enable) {
				services.pipewire.wireplumber.extraConfig = {
					"monitor.bluez.properties" = {
						"bluez5.enable-sbc-xq" = true;
						"bluez5.enable-msbc" = true;
						"bluez5.enable-hw-volume" = true;
						"bluez5.roles" = [
							"hsp_hs"
							"hsp_ag"
							"hfp_hf"
							"hfp_ag"
						];
					};
				};
			};
	};
}
