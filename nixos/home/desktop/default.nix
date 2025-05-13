{ config, pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./i3.nix
    ./waybar.nix
    ./swaylock.nix
    ./sway.nix
    ./gnome.nix
  ];
  
  xdg = {
    enable = true;
  };

}
