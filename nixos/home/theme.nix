{ config, pkgs, lib, ... }:

let
  catppuccin-gtk-theme = import ./catppuccin-gtk-theme.nix {
    lib = pkgs.lib;
    stdenv = pkgs.stdenv;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    gtk-engine-murrine = pkgs.gtk-engine-murrine;
    jdupes = pkgs.jdupes;
    sassc = pkgs.sassc;
    accent = ["default"];
    shade = "dark";
    size = "standard";
  };
  bg_wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Sahil-958/walls/refs/heads/main/hyprdots/Catppuccin-Mocha/cat_leaves.png";
    sha256 = "1894y61nx3p970qzxmqjvslaalbl2skj5sgzvk38xd4qmlmi9s4i";
  };
in
{
  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file:///home/makano/Documents"
      "file:///home/makano/Downloads"
      "file:///home/makano/Games"
      "file:///home/makano/Music"
      "file:///home/makano/Pictures"
      "file:///home/makano/Videos"
      "file:///home/makano/workspace"
    ];
    iconTheme = {
      package = pkgs.epapirus-icon-theme;
      name = "ePapirus-Dark";
    };
    # cursorTheme = {
    #   package = lib.mkForce pkgs.google-cursor;
    #   name = lib.mkForce "GoogleDot-Black";
    #   size = 12;
    # };
    theme = {
      package = catppuccin-gtk-theme;
      name = "Catppuccin-Dark";
    };
  };

  # programs.gnome-shell.theme = {
  #   package = catppuccin-gtk-theme;
  #   name = "Catppuccin-Dark";
  # };

  home.file."${config.home.homeDirectory}/.themes/Catppuccin-Dark" = {
    source = "${catppuccin-gtk-theme}/share/themes/Catppuccin-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # home.pointerCursor = {
  #   package = lib.mkForce pkgs.catppuccin-cursors.mochaMauve;
  #   name = lib.mkForce "GoogleDot-Black";
  #   size = 12;
  # };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # stylix = {
  #   enable = true;

  #   targets.gnome.enable = false;
  #   polarity = "dark";
  #   image = bg_wallpaper;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  #   fonts = {
  #     serif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Serif";
  #     };

  #     sansSerif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Sans";
  #     };

  #     monospace = {
  #       package = pkgs.fira-code;
  #       name = "Fira Code NerdFont";
  #     };

  #     emoji = {
  #       package = pkgs.noto-fonts-emoji;
  #       name = "Noto Color Emoji";
  #     };
  #   };
  # };
  

  xdg.configFile.hyprpaper = {
    target = "hypr/hyprpaper.conf";
    text = ''
      preload = ${bg_wallpaper}
      wallpaper = eDP-1,${bg_wallpaper}
      splash = false
    '';
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
      ];
    };
  };
}
