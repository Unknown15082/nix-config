# Commands

# Display all possible targets
help:
	@just --list --justfile {{justfile()}}

# Switch to new version
switch *FLAGS: add
	@nh os switch {{FLAGS}}

# Test new version
test *FLAGS: add
	@nh os test {{FLAGS}}

# Reinstall bootloader
reinstall-bootloader:
	@sudo nixos-rebuild switch --install-bootloader

# Add all files to git
add:
	@git add .

# Update flake inputs
update:
	@just switch -u --commit-lock-file

# Deploy to remote host
deploy host:
	@just switch -H {{host}} --target-host {{host}}
