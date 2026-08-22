{ ... }: {
    flake.modules.homeManager.modernUnix = { config, pkgs, ... }: {
        home.packages = with pkgs; [
            fastfetch
            btop-rocm
            dust
            duf
            ripgrep
            fd
            lazygit
            unzip
            bat
            imv
            tealdeer
            yazi
        ];

        programs.git = {
            enable = true;

            settings = {
                core.excludesFile = "${config.home.homeDirectory}/.gitignore";
                
                alias = {
                    aliases = "config --get-regexp alias";
                    amend = "commit --amend --no-edit";
                    lol = "log --oneline --decorate";
                };
            };
        };

        programs.fzf.enable = true;

        programs.eza = {
            enable = true;
            enableFishIntegration = true;
        };

        programs.zoxide = {
            enable = true;
            enableFishIntegration = true;

            options = [ "--cmd cd" ];
        };
    };

    flake.modules.homeManager.gitSigning = { config, ... }: {
        programs.git = {
            signing = {
                key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
                format = "ssh";
                signByDefault = true;
            };
        };
    };

    flake.modules.homeManager.nixtools = {
        programs.direnv = {
            enable = true;
            silent = true;
            nix-direnv.enable = true;
        };
    };
}
