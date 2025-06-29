{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    # font = {
    #   name = "Fira Code Nerdfont";
    #   size = 12.0;
    # };
    shellIntegration.enableZshIntegration = true;
    # shellIntegration.enableNushellIntegration = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      term = "xterm-256color";
      cursor_shape = "block";
      window_padding_width = 5;
      cursor_blink_interval = 0;
      background_opacity = lib.mkForce 0.8;
      mouse_hide_wait = 0;
      cursor_trail = 1;
      padding_top = 2;
      padding_left = 20;
      padding_right = 20;
      # color7 = "#a6adc8";
      # color8 = "#bac2de";
      startup_session = "${pkgs.writeText "tmux-session.conf" ''launch tmux''}";
    };
  };
}
