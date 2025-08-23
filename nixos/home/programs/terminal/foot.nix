{ config, pkgs, lib, ... }:

{
  programs.foot = {
    enable = true;
    server = {
      enable = true;
    };
    settings = {
      main = {
        term = "xterm-256color";
        # font = "Fira Code Nerdfont:size=10";
        # dpi-aware = "yes";
        pad = "25x1";
        shell = "tmux";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
      	alpha = lib.mkForce 0.8;
      };
    };
  };
}
