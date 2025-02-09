{ lib, config, osConfig, inputs, system, pkgs, ... }:
let
	cfg = config.modules.games.osu;
	nvidiaOffload = osConfig.hardware.nvidia.prime.offload.enable;
	nvidiaCommand = if nvidiaOffload then "nvidia-offload " else "";
	makeNvidiaDesktopItem = attrs: pkgs.makeDesktopItem (attrs // { exec = nvidiaCommand + attrs.exec; });
in
{
	options.modules.games.osu = {
		enable = lib.mkEnableOption "osu!";
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			# Override to use dGPU
			(inputs.nix-gaming.packages.${system}.osu-lazer-bin.override {
				makeDesktopItem = makeNvidiaDesktopItem;
			})
		];
	};
}
