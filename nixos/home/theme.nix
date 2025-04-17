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
    cursorTheme = {
      package = lib.mkForce pkgs.google-cursor;
      name = lib.mkForce "GoogleDot-Black";
      size = 12;
    };
    theme = {
      package = catppuccin-gtk-theme;
      name = "Catppuccin-Dark";
    };
  };

  home.file."${config.home.homeDirectory}/.themes/Catppuccin-Dark" = {
    source = "${catppuccin-gtk-theme}/share/themes/Catppuccin-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home.pointerCursor = {
    package = lib.mkForce pkgs.google-cursor;
    name = lib.mkForce "GoogleDot-Black";
    size = 12;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
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