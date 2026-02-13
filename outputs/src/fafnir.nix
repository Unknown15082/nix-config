{
    inputs,
    libutils,
    ...
}@args:
let
    inherit (libutils) relativeToRoot;
    name = "fafnir";

    nixos-modules = map relativeToRoot [
        "nixos-modules"
        "secrets"
        "hosts/${name}/configuration.nix"
    ];

    home-modules = map relativeToRoot [
        "home-modules"
        "hosts/${name}/home.nix"
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
