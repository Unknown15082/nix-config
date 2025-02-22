{ lib, config, inputs, system, pkgs, ... }:
let
	cfg = config.modules.games.osu;
	nvidiaOffload = config.hardware.nvidia.prime.offload.enable;
	nvidiaCommand = if nvidiaOffload then "nvidia-offload " else "";
	makeNvidiaDesktopItem = attrs: pkgs.makeDesktopItem (attrs // { exec = nvidiaCommand + attrs.exec; });
in
{
	options.modules.games.osu = {
		enable = lib.mkEnableOption "osu!";
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [
			# Override to use dGPU
			(inputs.nix-gaming.packages.${system}.osu-lazer-bin.override {
				makeDesktopItem = makeNvidiaDesktopItem;
			})
		];

		nix.settings = {
			substituters = [ "https://nix-gaming.cachix.org" ];
			trusted-public-keys = [
				"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
			];
		};
	};
}
