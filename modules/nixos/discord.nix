{ pkgs, ... }:
{
	environment.systemPackages = [
		pkgs.vesktop
	];

	# Add overrides, which includes OpenASAR, Vencord, TTS, ...
}
