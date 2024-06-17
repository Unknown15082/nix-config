{ pkgs, ... }:
{
	# TODO: Move this module to each user (home-manager)
	environment.systemPackages = with pkgs; [
		osu-lazer-bin
	];
}
