{ inputs, lib, config, system, ... }:
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
		};
	};
}
