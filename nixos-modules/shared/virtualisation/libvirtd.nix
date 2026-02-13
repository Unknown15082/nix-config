{
    lib,
    libutils,
    config,
    pkgs,
    username,
    ...
}:
let
    cfg = config.modules.virtualisation.libvirtd;
in
{
    options.modules.virtualisation.libvirtd = {
        enable = lib.mkEnableOption "libvirtd";
    };

    config = lib.mkIf cfg.enable {
        virtualisation.libvirtd = {
            enable = true;
            qemu = {
                package = pkgs.qemu_kvm;
                runAsRoot = true;
                swtpm.enable = true;
            };
        };

        # TODO: Use modules.users
        users.users.${username} = {
            extraGroups = [ "libvirtd" ];
        };

        environment.systemPackages = with pkgs; [
            virt-manager
        ];
    };
}
