{ config, lib, pkgs, inputs, ... }:

{
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

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    fira-code
    fira-code-symbols
    font-awesome
    jetbrains-mono
    # nerd-fonts.fira-code
    (nerdfonts.override {
    	fonts = [ "FiraCode" "DroidSansMono" ];
    })
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
      XCURSOR_THEME = "GoogleDot-Black";
    };
    systemPackages = with pkgs; [
      stdenv
      alacritty
      android-tools
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
      kdenlive
      # kooha
      hyprpaper
      libnotify
      linuxHeaders
      lm_sensors
      # logseq
      lshw
      lutris
      lxappearance
      mate.caja-with-extensions
      mate.caja-extensions
      micro
      mission-center
      # mongodb
      ncdu
      ntfs3g
      nautilus
      networkmanagerapplet
      inputs.nix-software-center.packages.${system}.nix-software-center
      # nix-autobahn
      # ngrok
      nodePackages_latest.nodejs
      # nodejs_22
      openjdk17-bootstrap
      obs-studio
      onlyoffice-desktopeditors
      pavucontrol
      pamixer
      pciutils
      pulseaudio
      playerctl
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
      remmina
      rcm
      rofi
      scrcpy
      slurp
      smartmontools
      swappy
      swww
      sushi
      telegram-desktop
      turtle
      vlc
      weechat
      wine
      wine64
      wl-clipboard
      xorg.xinit
      xorg.xorgserver
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
      zenity

      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
        pkgs.buildFHSUserEnv (base // {
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
