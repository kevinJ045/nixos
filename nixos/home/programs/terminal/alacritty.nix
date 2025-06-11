{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 20;
          y = 20;
        };
        # opacity = 0.9;
        decorations = "full";
      };

      # font = {
      #   normal = {
      #     family = "JetBrains Mono";
      #     style = "Regular";
      #   };
      #   size = 12.0;
      # };
    };
  };
}
