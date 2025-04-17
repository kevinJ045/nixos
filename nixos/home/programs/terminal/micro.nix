{ config, pkgs, lib, ... }:

{
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      colorscheme = "catppuccin-mocha";
      mkparents = true;
    };
  };
}