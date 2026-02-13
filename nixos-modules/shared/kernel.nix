{
    lib,
    config,
    pkgs,
    ...
}:
let
    cfg = config.modules.kernel;
in
{
    options.modules.kernel = {
        # TODO: Make enum for kernel versions
        enable = lib.mkEnableOption "Linux kernel";
    };

    config = lib.mkIf cfg.enable {
        boot.kernelPackages = pkgs.linuxPackages_zen;
    };
}
