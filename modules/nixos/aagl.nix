{ inputs, ... }:
{
	imports = [ inputs.aagl.nixosModules.default ];

	programs.anime-game-launcher.enable = true;
	programs.honkers-railway-launcher.enable = true;
}
