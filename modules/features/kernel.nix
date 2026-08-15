{ pkgs, ... }: {
	flake.modules.nixos.kernel = {
		boot.kernelPackages = pkgs.linuxPackages_zen;
	};
}
