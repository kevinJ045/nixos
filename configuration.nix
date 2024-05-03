
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.loader.grub.enable = true;
  boot.loader.grub.memtest86.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;
    
  nixpkgs.config.allowUnfree = true;

  hardware.opengl.driSupport32Bit = true;

  networking.hostName = "Decile";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  networking.firewall.checkReversePath = false;

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
  };

  programs.zsh.enable = true;

  users.users.makano = {
    isNormalUser = true;
    home = "/home/makano";
    description = "Makano";
    extraGroups = ["wheel" "networkmanager"];
    packages = with pkgs; [
      flatpak
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    stdenv
    alacritty
    blueman
    bun
    brightnessctl
    chromium
    gnome.nautilus
    podman
    distrobox
    dmenu
    dxvk
    gimp
    gnome.gnome-tweaks
    gparted
    grim
    glib
    grimblast
    htop
    inkscape
    jq
    killall
    hyprpaper
    libnotify
    lm_sensors
    lshw
    lutris
    lxappearance
    mate.caja-with-extensions
    mate.caja-extensions
    # mongodb
    ncdu
    # nix-autobahn
    # ngrok
    nodejs
    openjdk17-bootstrap
    pamixer
    playerctl
    python3
    python311Packages.pip
    ranger
    rcm
    rofi
    slurp
    swappy
    swww
    steam
    telegram-desktop
    vlc
    vscode
    weechat
    wine
    wine64
    wl-clipboard
	xorg.xinit
    xdg-utils
    zsh-autosuggestions
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-fast-syntax-highlighting
    zip
    unzip
  ];
  
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    fira-code
    fira-code-symbols
    font-awesome
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  xdg = {
    autostart.enable = true;
    portal = {
      config.common.default = "gtk";
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  services.flatpak.enable = true;
  services.udisks2.enable = true;
  services.gnome.gnome-keyring.enable = true;
  # services.xserver = {
  	# enable = true;
  	# displayManager.gdm.enable = true;
  	# desktopManager.gnome.enable = true;
  	# desktopManager.xfce.enable = true;
  	# desktopManager.default = "none";
  	# desktopManager.xterm.enabe = false;
  	# displayManager.lightdm.enable = true;
  	# windowManager.i3.enable = true;
  # };

  # services.xserver.desktopManager.xfce.enable = true;

  services.openssh.enable = true;

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
