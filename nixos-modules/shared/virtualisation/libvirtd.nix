{ lib, utils, config, pkgs, username, ... }:
let
	cfg = config.modules.virtualisation.libvirtd;
in
{
	options.modules.virtualisation.libvirtd = {
		enable = utils.mkEnableTrueOption "libvirtd";
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

		# TODO: Use modules.users
		users.users.${username} = {
			extraGroups = [ "libvirtd" ];
		};

		environment.systemPackages = with pkgs; [
			virt-manager
		];
	};
}
