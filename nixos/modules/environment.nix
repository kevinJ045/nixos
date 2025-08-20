{ config, lib, pkgs, inputs, ... }:


# let 
#   unstable = import (fetchTarball {
#       url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-unstable.tar.gz";
#       sha256 = "1s3lxb33cwazlx72pygcbcc76bbgbhdil6q9bhqbzbjxj001zk0w";
#     }) {
#       system = "x86_64-linux";
#       config.allowUnfree = true;
#     };
#   in
{
  nixpkgs.config.allowUnfree = true;

  # jovian = {
  #   steam = {
  #     enable = true;
  #     user = "makano045";
  #   };
  # };

  programs.steam = {
  	enable = true;
  	extraCompatPackages = [ pkgs.proton-ge-bin ];
    extest = {
    	enable = true;
    };
    gamescopeSession = {
    	enable = true;
		  args = [ "--expose-wayland" "-e" ];
    };
  };

  programs.chromium.enable = true;
  programs.niri.enable = true;
  # programs.swayfx.enable = true;
  programs.sway.enable = true;
  programs.sway.package = pkgs.swayfx;
  # programs.sunshine.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    fira-code
    fira-code-symbols
    font-awesome
    jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    # (nerdfonts.override {
    # 	fonts = [ "FiraCode" "DroidSansMono" ];
    # })
  ];


  environment = {
    sessionVariables = rec {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
      XDG_DESKTOP_DIR = "$HOME/Desktop";
      XDG_DOWNLOAD_DIR = "$HOME/Downloads";
      XDG_TEMPLATES_DIR = "$HOME/Templates";
      XDG_PUBLICSHARE_DIR = "$HOME/Public";
      XDG_DOCUMENTS_DIR = "$HOME/Documents";
      XDG_MUSIC_DIR = "$HOME/Music";
      XDG_PICTURES_DIR = "$HOME/Pictures";
      XDG_VIDEOS_DIR = "$HOME/Videos";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "sway";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      MOZ_ENABLE_WAYLAND = "1";
      # XCURSOR_THEME = "GoogleDot-Black";
    };
    systemPackages = with pkgs; [
      nushell
      stdenv
      amberol
      alacritty
      android-tools
      android-studio
      appimage-run
      blueman
      blender
      # nanovdb
      baobab
      bottles
      bun
      brightnessctl
      chromium
      clang
      cliphist
      cacert
      clipnotify
      podman
      # darft
      distrobox
      dconf-editor
      # droidmote
      dmenu
      dxvk
      errands
      firefox
      flutter
      file-roller
      folio
      freetype
      fragments
      fractal
      fd
      gcc-unwrapped
      gimp
      gthumb
      gnome-tweaks
      # gnome-boxes
      gparted
      grim
      glib
      gpu-screen-recorder-gtk
      grimblast
      gvfs
      gnome.gvfs
      htop
      hdparm
      inkscape
      inetutils
      jq
      killall
      krita
      kando
      kdePackages.kdenlive
      kdePackages.kdeconnect-kde
      kdePackages.qt6ct
      libsForQt5.qt5ct
      librewolf
      # kooha
      hyprpaper
      libnotify
      linuxHeaders
      lm_sensors
      # logseq
      lshw
      lutris
      # lunarvim
      lxappearance
      mate.caja-with-extensions
      mate.caja-extensions
      micro
      mission-center
      musikcube
      # mongodb
      ncdu
      ntfs3g
      nautilus
      # neovide
      # niri
      nixd
      networkmanagerapplet
      # inputs.nix-software-center.packages.${system}.nix-software-center
      # inputs.nixpkgs-unstable.packages."${system}".default
      # nix-autobahn
      # ngrok
      nodePackages_latest.nodejs
      # nodejs_22
      # openjdk17-bootstrap
      jdk
      obs-studio
      onlyoffice-desktopeditors
      pavucontrol
      pamixer
      pciutils
      pulseaudio
      playerctl
      protonvpn-cli
      protonvpn-gui
      ppsspp
      python3
      python312Packages.pip
      python312Packages.inquirerpy
      python312Packages.requests
      python312Packages.tqdm 
      python312Packages.tkinter
      python312Packages.setuptools
      python312Packages.ds4drv
      pods
      # gstreamer
      # gst-plugins-base
      # gst-plugins-good
      # gst-plugins-bad
      # gst-libav
      # pipewire
      ranger
      ryubing
      remmina
      rcm
      rofi
      cargo
      rustc
      rustfmt
      rust-analyzer
      scrcpy
      slurp
      smartmontools
      swappy
      swww
      sushi
      socat
      stretchly
      # swaynotificationcenter
      # sunshine
      telegram-desktop
      turtle
      umu-launcher
      vlc
      weechat
      wine
      wine64
      wl-clipboard
      xorg.xinit
      xorg.xorgserver
      xwayland-satellite
      xdg-desktop-portal-gnome
      xdg-user-dirs
      xdg-utils
      zsh-autosuggestions
      zsh-completions
      zsh-powerlevel10k
      zsh-syntax-highlighting
      zsh-history-substring-search
      zsh-fast-syntax-highlighting
      zip
      unzip
      usbutils
      lan-mouse
      wineWowPackages.full
      winetricks
      wineWow64Packages.waylandFull
  	  wlrctl
  	  wayvnc
      zenity

      warp-terminal

      # unstable.niriswitcher
      # python313Packages.pygobject3
      # libadwaita
      # gtk4-layer-shell

      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
        pkgs.buildFHSEnv (base // {
        name = "fhs";
        targetPkgs = pkgs: (
          (base.targetPkgs pkgs) ++ [
            pkgs.pkg-config
            pkgs.ncurses
            libffi
            pcre2
            xorg.libXpm
            libepoxy
            pkgs.python3
          ]
        );
        profile = "export FHS=1";
        runScript = "zsh";
        extraOutputsToInstall = ["dev"];
      }))
    ];
  };
}
