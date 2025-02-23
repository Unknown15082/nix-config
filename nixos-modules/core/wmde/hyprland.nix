{ inputs, lib, config, system, pkgs, ... }:
let
	cfg = config.modules.hyprland;
in
{
	options.modules.hyprland = {
		enable = lib.mkEnableOption "Hyprland";
	};

	config = lib.mkIf cfg.enable {
		programs.hyprland = {
			enable = true;
			package = inputs.hyprland.packages."${system}".hyprland;
			withUWSM = true;
		};

		security.polkit.enable = true;
		environment.systemPackages = with pkgs; [
			hyprpolkitagent
		];

		# Enable hyprland's binary cache
		nix.settings = {
			substituters = [ "https://hyprland.cachix.org" ];
			trusted-public-keys = [
				"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
			];
		};

		hm.modules.hyprland.enable = true;
	};
}
