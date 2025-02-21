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
	};
}
