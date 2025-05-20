{ config, pkgs, lib, ... }:

{
    programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-popup'
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix
      bind-key C-a last-window
      bind-key a send-prefix
      bind-key b set status
      bind s split-window -v
      bind v split-window -h
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind-key p run-shell 'tmux-popup -h 80% -w 80% -E zsh'
      set -g mouse
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
