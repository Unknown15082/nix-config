{ inputs, ... }: {
    flake.modules.homeManager.discord = {
        imports = [
            inputs.nixcord.homeModules.nixcord
        ];

        programs.nixcord = {
            enable = true;
            discord.enable = false;
            vesktop.enable = true;

            discord.krisp.enable = true;
            discord.silenceNoModClientWarning = true;
        };
    };
}
