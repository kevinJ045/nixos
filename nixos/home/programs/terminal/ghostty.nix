{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 12;
      font-family = "FiraCode Nerd Font";
      window-padding-x = 16;
      cursor-style = "block";
      cursor-style-blink = false;
      command = "tmux";
      app-notifications = "no-clipboard-copy";
    };
  };
  programs.atuin = {
  	enable = true;
  	enableZshIntegration = true;
  	flags = [
  		"--disable-up-arrow"
  	];
  };
}
