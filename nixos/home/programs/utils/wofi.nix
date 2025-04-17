{ config, pkgs, lib, ... }:

{
    programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      dmenu = true;
      insensitive = true;
      prompt = "";
      width = "50%";
      lines = 15;
      location = "center";
      hide_scroll = true;
      allow_images = true;
    };
  };
}