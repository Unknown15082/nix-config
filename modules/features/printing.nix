{ pkgs, ... }: {
	flake.modules.nixos.printing = {
		services.printing = {
			enable = true;
			drivers = with pkgs; [ canon-capt ];
		};
	};
}
