{
    inputs,
    lib,
    system,
    myvars,
    genSpecialArgs,
    specialArgs ? (genSpecialArgs system),
    nixos-modules,
    home-modules ? [ ],
    ...
}:
let
    inherit (inputs) nixpkgs home-manager;
    inherit (myvars) username;

    hasHomeManager = (lib.lists.length home-modules) > 0;

    hmAlias =
        if hasHomeManager then
            lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ]
        else
            {
                options.hm = lib.mkSinkUndeclaredOptions { };
            };

    hmModules = lib.optionals hasHomeManager [
        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm.backup";
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users."${username}".imports = home-modules;
        }
    ];
in
nixpkgs.lib.nixosSystem {
    inherit system specialArgs;

    modules = nixos-modules ++ [ hmAlias ] ++ hmModules;
}
