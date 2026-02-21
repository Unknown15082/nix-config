{
    libutils,
    ...
}@args:
let
    inherit (libutils) relativeToRoot;
    name = "scylla";

    nixos-modules = map relativeToRoot [
        "nixos-modules"
        "hosts/${name}/configuration.nix"
    ];
in
{
    nixosConfigurations = libutils.nixosSystem (
        args
        // {
            inherit nixos-modules;
        }
    );
}
