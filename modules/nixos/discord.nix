{ pkgs, ... }:
{
	environment.systemPackages = [
		pkgs.vesktop
		(pkgs.discord.override {
			withOpenASAR = true;
			withVencord = true;
			withTTS = true;
		})
	];

	# Add overrides, which includes OpenASAR, Vencord, TTS, ...
}
