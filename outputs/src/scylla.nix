{
    libutils,
    inputs,
    system,
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
rec {
    nixosConfigurations = libutils.nixosSystem (
        args
        // {
            inherit nixos-modules;
        }
    );

    nodes = {
        hostname = name;
        sshUser = "root";
        profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.${system}.activate.nixos nixosConfigurations;
        };
    };
}
