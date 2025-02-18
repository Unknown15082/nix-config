# NixOS Custom Installation

This installer is customized with specific shell settings, additional packages, a `justfile` for commands, and a SSH key to perform this installation remotely.

You can view the source code for this .iso file in the [Github Repository](https://github.com/Unknown15082/nix-config). This `.iso` file is created using:
```
nixos-generators --format iso --flake .#customISO -o result/iso
```

## Details

This installer contains:

- Flakes support.
- `NetworkManager` instead of `wpa_supplicant`.
- An preconfigured authorized SSH key, to perform the installation remotely.
- Additional packages, which includes [a custom Neovim](https://github.com/Unknown15082/nixvim-config), `git` and other packages.
- A `justfile` for common commands.
