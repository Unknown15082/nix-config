# Commands

# Display all possible targets
help:
	@just --list --justfile {{justfile()}}

# Switch to new version
switch: add
	@nh os switch

# Test new version
test: add
	@nh os test

# Reinstall bootloader
reinstall-bootloader:
	@sudo nixos-rebuild switch --install-bootloader

# Add all files to git
add:
	@git add .

# Push changes to git
push:
	@git push

# Create a commit
commit message: add
	@git commit -m {{message}}

# Amend the previous commit
amend: add
	@git commit --amend --no-edit

# Update flake inputs
update:
	@nix flake update
	@just commit "nix flake update"
	@just switch

# Deploy to remote host
deploy host:
	@nixos-rebuild switch --flake .#{{host}} --target-host {{host}}
