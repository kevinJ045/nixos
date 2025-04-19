{ config, lib, pkgs, ... }:

{
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
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  zramSwap.enable = true;
  services = {
    udev.extraRules = ''
      KERNEL=="ntsync", MODE="0660", TAG+="uaccess"
    '';
    fwupd.enable = true;
    ollama = {
      enable = true;
      loadModels = [ "deepseek-r1:1.5b" ];
    };
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    dbus.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    udisks2.enable = true;
    gnome.gnome-keyring.enable = true;
    libinput = {
      enable = true;
      touchpad.tapping = true;
    };
    # xserver = {
    #   enable = true;
    #   displayManager.gdm.enable = true;
    #   displayManager.startx.enable = true;
    #   desktopManager.gnome.enable = true;
    # };
    vsftpd = {
      enable = true;
      localUsers = true;
      writeEnable = true;
      localRoot = "/home/makano";
      extraConfig = ''
        pasv_enable=Yes
        pasv_min_port=10000
        pasv_max_port=10100
      '';
      userlist = [ "makano" ];
      userlistEnable = true;
    };
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "sh -c 'LD_LIBRARY_PATH=\"\" dbus-run-session Hyprland'";
          user = "makano";
        };
        default_session = initial_session;
      };
    };
  };
}