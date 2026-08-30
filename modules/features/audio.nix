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

        security.rtkit.enable = true;
    };

    flake.modules.nixos.zenbookAudioFixes = {
        boot.extraModprobeConfig = ''
            install snd_hda_codec_hdmi /bin/true
        '';

        boot.blacklistedKernelModules = [ "snd_hda_codec_hdmi" ];
    };
}
