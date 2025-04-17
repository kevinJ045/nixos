{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code Nerdfont";
      size = 12.0;
    };
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      cursor_shape = "block";
      window_padding_width = 5;
      cursor_blink_interval = 0;
    };
  };
}