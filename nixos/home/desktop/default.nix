{ config, pkgs, lib, ... }:

let
  bg_wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Sahil-958/walls/refs/heads/main/hyprdots/Catppuccin-Mocha/cat_leaves.png";
    sha256 = "1894y61nx3p970qzxmqjvslaalbl2skj5sgzvk38xd4qmlmi9s4i";
  };
in
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

  xdg.configFile.hyprpaper = {
    target = "hypr/hyprpaper.conf";
    text = ''
      preload = ${bg_wallpaper}
      wallpaper = eDP-1,${bg_wallpaper}
      splash = false
    '';
  };
}
