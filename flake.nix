{
    description = "NixOS configuration flake";

    inputs = {
        #--- MAIN INPUTS ---#
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-parts.url = "github:hercules-ci/flake-parts";
        import-tree.url = "github:vic/import-tree";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        #--- EXTRA INPUTS ---#
        hyprland.url = "github:hyprwm/Hyprland";
        catppuccin.url = "github:catppuccin/nix";
        nixvim-config.url = "github:Unknown15082/nixvim-config";

        nix-gaming = {
            url = "github:fufexan/nix-gaming";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixcord = {
            url = "github:4evy/nixcord";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        waybar = {
            url = "github:Alexays/Waybar";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        #--- SECRETS ---#
        secrets = {
            url = "git+ssh://git@github.com/Unknown15082/nix-secrets.git?shallow=1";
            flake = false;
        };
    };

    outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
