{
    inputs,
    libutils,
    ...
}@args:
let
    inherit (libutils) relativeToRoot;
    name = "fafnir";

    nixos-modules =
        map relativeToRoot [
            "nixos-modules"
            "secrets"
            "hosts/${name}/configuration.nix"
        ]
        ++ [
            # TODO: Move to separate module
            inputs.catppuccin.nixosModules.catppuccin
            inputs.stylix.nixosModules.stylix
            inputs.nix-index-database.nixosModules.nix-index
            inputs.agenix.nixosModules.default
        ];

    home-modules =
        map relativeToRoot [
            "home-modules"
            "hosts/${name}/home.nix"
        ]
        ++ [
            # TODO: Move to separate module
            inputs.catppuccin.homeModules.catppuccin
            inputs.agenix.homeManagerModules.default
        ];
in
{
    nixosConfigurations = libutils.nixosSystem (
        args
        // {
            inherit nixos-modules home-modules;
        }
    );
}
