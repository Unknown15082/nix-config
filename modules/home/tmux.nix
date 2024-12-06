{ lib, config, pkgs, ... }:
let
	cfg = config.modules.shell-utils;
in
{
	config = lib.mkIf cfg.enableTmux {
		programs.tmux = {
			enable = true;

			shortcut = "a"; # Set prefix to C-a

			sensibleOnTop = true;
			plugins = with pkgs; [
				{
					plugin = tmuxPlugins.resurrect;
				}
				{
					plugin = tmuxPlugins.continuum;
					extraConfig = ''
						set -g @continuum-restore 'on'
						set -g @continuum-save-interval '1'
					'';
				}
				{
					plugin = tmuxPlugins.catppuccin;
					extraConfig = ''
						set -g @catppuccin-flavour 'mocha'
					'';
				}
			];

			shell = "${pkgs.fish}/bin/fish";
			clock24 = true;
			mouse = true;
			disableConfirmationPrompt = true;
			baseIndex = 1;
			escapeTime = 0;
			historyLimit = 50000;
			terminal = "xterm-256color";

			extraConfig = ''
			# Alt-arrow to switch panes
			# Shift-arrow to switch windows
				bind -n M-Left select-pane -L
				bind -n M-Down select-pane -D
				bind -n M-Up select-pane -U
				bind -n M-Right select-pane -R

				bind -n S-Left previous-window
				bind -n S-Right next-window

			# Better keybinds for splitting
				bind v split-window -h -c "#{pane_current_path}"
				bind h split-window -v -c "#{pane_current_path}"

			# Open new window in current working directory
				bind c new-window -c "#{pane_current_path}"

			# Toggle fullscreen pane
				bind f resize-pane -Z

			# Enable 24-bit color
				set-option -sa terminal-overrides ",xterm-256color:Tc"

			# Enable vi-mode copy
				setw -g mode-keys vi
			'';
		};
	};
}
