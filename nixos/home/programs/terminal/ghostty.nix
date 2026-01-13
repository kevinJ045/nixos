
{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 12;
      font-family = "FiraCode Nerd Font";
      window-padding-x = 8;
      cursor-style = "block";
      cursor-style-blink = false;
      command = "tmux";
      background-opacity = 0.8;
      app-notifications = "no-clipboard-copy";
    };
  };
  # programs.atuin = {
  # 	enable = true;
  # 	enableZshIntegration = true;
  # 	flags = [
  # 		"--disable-up-arrow"
  # 	];
  # };
}
