{ lib, mylib, config, pkgs, username, ... }:
let
	cfg = config.modules.libvirtd;
in
{
	options.modules.libvirtd = {
		enable = mylib.mkEnableTrueOption "libvirtd";
	};

	config = lib.mkIf cfg.enable {
		virtualisation.libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu_kvm;
				runAsRoot = true;
				swtpm.enable = true;
				ovmf = {
					enable = true;
					packages = [(pkgs.OVMF.override {
						secureBoot = true;
						tpmSupport = true;
					}).fd];
				};
			};
		};

		users.users.${username} = {
			extraGroups = [ "libvirtd" ];
		};

		environment.systemPackages = with pkgs; [
			virt-manager
		];
	};
}
