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
    url = "https://raw.githubusercontent.com/kevinj045/nixos/refs/heads/main/nixos/assets/wallpaper.png";
    sha256 = "1fya6dpplyjcbwhcn85bhp7irah2sd84ciani7f2c9gi3gnyz6g1";
  };
  cool-dark-icons = pkgs.stdenv.mkDerivation {
    pname = "cool-dark-icons";
    version = "unstable";
    
    propagatedBuildInputs = with pkgs; [
      # kdePackages.breeze-icons
      adwaita-icon-theme
      hicolor-icon-theme
    ];
  
    src = pkgs.fetchFromGitHub {
      owner = "L4ki";
      repo = "Cool-Plasma-Themes";
      rev = "9a1d0f2cd2b62bbcf8a7f15cb1e7ea4cab75bebc"; # Latest commit as of July 2025
      sha256 = "sha256-ekzpoEHOt7fwUBmIl+goaQTD9VswsULxU6G1TBcdItk="; # placeholder, will tell you how to get correct one
    };

    dontDropIconThemeCache = true;
  
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r "Cool Icons Themes/Cool-Dark-Icons" $out/share/icons/
    '';
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
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus-Dark";
    };
    cursorTheme = {
      package = lib.mkForce pkgs.catppuccin-cursors.mochaMauve;
      name = lib.mkForce "catppuccin-mocha-mauve-cursors";
      size = 24;
    };
    theme = {
      package = lib.mkForce catppuccin-gtk-theme;
      name = lib.mkForce "Catppuccin-Dark";
    };
  };

  # programs.gnome-shell.theme = {
  #   package = catppuccin-gtk-theme;
  #   name = "Catppuccin-Dark";
  # };

  home.file."${config.home.homeDirectory}/.themes/Catppuccin-Dark" = {
    source = "${catppuccin-gtk-theme}/share/themes/Catppuccin-Dark";
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "kvantum";
  #   style.name = "kvantum";
  # };

  home.pointerCursor = {
    package = lib.mkForce pkgs.catppuccin-cursors.mochaMauve;
    name = lib.mkForce "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  # catppuccin = {
  #   enable = true;
  #   flavor = "mocha";
  # };

  catppuccin.flavor = "mocha";
  catppuccin.swaync.enable = true;
  catppuccin.nvim.enable = true;

  stylix = {
    enable = true;

    targets.gnome.enable = false;
    targets.vscode.enable = false;
    targets.hyprpaper.enable = false;
    targets.waybar.enable = false;
    targets.gtk.enable = false;
    targets.neovide.enable = false;
    targets.neovim.enable = false;
    targets.swaync.enable = false;
    # targets.foot.enable = false;
    polarity = "dark";
    image = bg_wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code NerdFont";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  

  xdg.configFile.hyprpaper = {
    target = "hypr/hyprpaper.conf";
    text = ''
      preload = ${bg_wallpaper}
      wallpaper = eDP-1,${bg_wallpaper}
      wallpaper = HDMI-A-1,${bg_wallpaper}
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
