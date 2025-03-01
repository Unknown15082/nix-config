{ lib, config, ... }:
let
	cfg = config.modules.ghostty;
in
{
	options.modules.ghostty = {
		enable = lib.mkEnableOption "Ghostty";
	};

	config = lib.mkIf cfg.enable {
		programs.ghostty = {
			enable = true;
			enableFishIntegration = true;
			installBatSyntax = true;

			settings = {
				# Add settings
			};
		};
	};
}
