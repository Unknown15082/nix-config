{ pkgs, lib, myvars, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostName = "bahamut";

    presets.desktop.enable = true;
    modules.nvidia.enable = lib.mkForce false;

    modules.users.username = myvars.username;

    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    modules.hyprland.enable = true;

    modules.bluetooth.bt-sync.enable = false;

    services.openssh.enable = true;

    system.stateVersion = "26.05";
}
