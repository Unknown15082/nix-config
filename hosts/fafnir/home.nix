{
    inputs,
    config,
    pkgs,
    username,
    system,
    ...
}:
{
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "23.11";
    programs.home-manager.enable = true;

    # Add packages
    home.packages = with pkgs; [
        # Essential tools
        firefox
        gcc
        gdb
        wl-clipboard
        gnupg

        # Other tools
        openfortivpn # Connecting with SoC VPN (NUS)
        hugo # Blog sites
        zoom-us # Zoom meetings
        zathura # Viewing PDFs with VimTex
        xournalpp # Tablet sketching
        obsidian # Note-taking and tasks tracking
        gparted
        just
        gcalcli
        nchat
        anki-bin
        fastmail-desktop

        # Coding stuff
        # TODO: Move to specific devshells
        jetbrains.idea-oss
        jdk
        vscode
        typst
        pre-commit

        # Personal NixVim config
        inputs.nixvim-config.packages.${system}.default

        # Agenix CLI
        inputs.agenix.packages.${system}.default

        # Deploy-rs CLI
        inputs.deploy-rs.packages.${system}.default
    ];

    # Setup git
    programs.git = {
        enable = true;

        signing = {
            key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
            format = "ssh";
            signByDefault = true;
        };

        settings = {
            core = {
                excludesFile = "${config.home.homeDirectory}/.gitignore";
            };

            user.name = "Unknown15082";
            user.email = "trangiahuy15082006@gmail.com";

            alias = {
                amend = "commit --amend --no-edit";
                aliases = "config --get-regexp alias";
            };
        };
    };

    # Neovim as default
    home.sessionVariables = {
        EDITOR = "nvim";
        ANKI_WAYLAND = "1";
    };

    # Enable Discord
    modules.discord.enable = true;
    modules.discord.addons = true;

    # Enable spotify-player
    modules.spotify-player.enable = true;
    
    # Enable playerctl
    modules.playerctl.enable = true;

    # Use ghostty instead of alacritty
    modules.ghostty.enable = true;

    # Enable shell-utils
    modules.shell-utils.enable = true;

    # Testing out IAMB (TODO: Move to module)
    programs.iamb = {
        enable = true;
        settings = {
            default_profile = "dtth";

            profiles.dtth = {
                user_id = "@unknown1508:dtth.ch";
            };

            settings = {
                notifications.enabled = true;
                image_preview.protocol.type = "kitty";
            };
        };
    };

    # Set agenix identity path
    age.identityPaths = [
    ];
}
