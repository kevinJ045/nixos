
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # boot.loader.grub.enable = true;
  # boot.loader.grub.memtest86.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.theme = pkgs.catppuccin-grub;
  # boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModprobeConfig = ''
	options usbcore use_both_schemes=y
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = false;
    # dates = "weekly";
    # options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;
  
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  
  services.pulseaudio.enable = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  # networking.useDHCP = false;
  networking.firewall.checkReversePath = false;
  networking.firewall.allowedTCPPorts = [
      20    # FTP Data Port
      21    # FTP Command Port
      10000 # Passive FTP range start
      10100 # Passive FTP range end
  ];

  time.timeZone = "Africa/Addis_Ababa";

  services.fwupd.enable = true;

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  security.pam.services.swaylock = {};

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.zsh.enable = true;

  users.users.makano = {
    isNormalUser = true;
    home = "/home/makano";
    description = "Makano";
    extraGroups = ["wheel" "libvirtd" "kvm" "networkmanager" "audio" "sound" "video"];
    packages = with pkgs; [
      flatpak
      godot_4
    ];
    shell = pkgs.zsh;
  };

  environment.sessionVariables = rec {
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

  environment.systemPackages = with pkgs; [
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
    dart
    distrobox
    dconf-editor
    # droidmote
    dmenu
    dxvk
    errands
	firefox
	flutter
	file-roller
	# fragments
	gcc-unwrapped
    gimp
    gthumb
    gnome-tweaks
    gnome-boxes
    gparted
    grim
    glib
    grimblast
    gvfs
    gnome.gvfs
    htop
    hdparm
    inkscape
    inetutils
    jq
    killall
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
    # mongodb
    ncdu
    nautilus
    networkmanagerapplet
    # nix-autobahn
    # ngrok
    nodePackages_latest.nodejs
    openjdk17-bootstrap
    obs-studio
    # pavucontrol
    pamixer
    pciutils
    playerctl
    ppsspp
    python3
    python312Packages.pip
    python312Packages.inquirerpy
    python312Packages.requests
    python312Packages.tqdm 
    python312Packages.tkinter
    python312Packages.setuptools
    ranger
    remmina
    rcm
    rofi
    scrcpy
    slurp
    smartmontools
    swappy
    swww
    # steam
    telegram-desktop
    vlc
    vscode
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

    # (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
    #   pkgs.buildFHSEnv (base // {
    #   name = "fhs";
    #   targetPkgs = pkgs: (
    #     (base.targetPkgs pkgs) ++ [
    #       pkgs.pkg-config
    #       pkgs.ncurses
    #       libffi
    #       pcre2
    #       xorg.libXpm
    #       libepoxy
    #     ]
    #   );
    #   profile = "export FHS=1";
    #   runScript = "zsh";
    #   extraOutputsToInstall = ["dev"];
    # }))
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  

  virtualisation.libvirtd = {
	enable = true;
	qemu = {
	    package = pkgs.qemu_kvm;
	    runAsRoot = true;
	    swtpm.enable = true;
	    ovmf = {
	      enable = true;
	      packages = [(pkgs.OVMF.override {
	        secureBoot = true;
	        tpmSupport = true;
	      }).fd];
	    };
	};
  };
	
  
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
  ];

  xdg = {
    autostart.enable = true;
    portal = {
      config.common.default = "gtk";
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  services.gvfs.enable = true;
  services.flatpak.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.libinput = {
  	enable = true;
  	touchpad.tapping = true;
  	
  };

  services.vsftpd = {
      enable = true;
  
      # Enable local users to log in
      # localEnable = true;
      localUsers = true;
  
      # Enable write permissions for FTP users
      writeEnable = true;
  
      # Set the local root directory for the user 'makano'
      localRoot = "/home/makano";
  
      # Enable passive mode
      # pasvEnable = true;
      # pasvMinPort = 10000;
      # pasvMaxPort = 10100;
  
      # Disable anonymous login
      # anonymousEnable = false;
  	  # extraConfig = ''
		# anonymousEnable=Yes
  	  # '';
  	  extraConfig = ''
  	    pasv_enable=Yes
  	    pasv_min_port=10000
  	    pasv_max_port=10100
  	  '';
      # Chroot local users to their home directory
      # chrootLocalUser = true;

      userlist = [ "makano" ];
      userlistEnable = true;
  };
  networking.firewall.allowedTCPPortRanges = [ { from = 10000; to = 10100; } ];
    
  # services.xserver = {
  	# enable = true;
  	# displayManager.gdm.enable = true;
  	# desktopManager.gnome.enable = true;
  	# desktopManager.xfce.enable = true;
  	# desktopManager.default = "none";
  	# desktopManager.xterm.enabe = false;
  	# displayManager.lightdm.enable = false;
  	# windowManager.i3.enable = true;
  	# autorun = false;

  	# libinput.enable = true;

  	# libinput.enable = true;
  	# libinput.mouse.scrollMehod = "twofinger";
  	# libinput.touchpad.scrollMehod = "twofinger";
  # };

  # services.xserver.desktopManager.xfce.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs.dconf.enable = true;
  
  programs.nix-ld.enable = true;

  zramSwap.enable = true;

  virtualisation.containers.enable = true;
  virtualisation = {
  	podman = {
  		enable = true;
  		dockerCompat = true;
  		defaultNetwork.settings.dns_enabled = true;	
  	};
  };

  system.stateVersion = "23.11";
}
