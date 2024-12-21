{ lib, config, pkgs, ... }:
let
	cfg = config.modules.sddm;
in
{
	options.modules.sddm = {
		enable = lib.mkEnableOption "SDDM";
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [
			(pkgs.catppuccin-sddm.override {
				flavor = "mocha";
				font = config.stylix.fonts.sansSerif.name;
				fontSize = "12";
			})
		];

		services.xserver.enable = true;
		services.displayManager = {
			sddm = {
				enable = true;
				package = pkgs.kdePackages.sddm;
				
				theme = "catppuccin-mocha";
			};
		};

		security.pam.services.sddm.enableGnomeKeyring = true;
	};
}
