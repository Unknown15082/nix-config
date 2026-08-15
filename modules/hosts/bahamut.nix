{ self, inputs, ... }: {
	flake.modules.nixos.hosts.bahamut = { pkgs, ... }: {
	};

	flake.nixosConfigurations.bahamut = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			self.modules.nixos.hosts.bahamut
		];
	};
}
