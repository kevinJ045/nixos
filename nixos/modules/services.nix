{ config, lib, pkgs, ... }:

{
  # xdg = {
  #   autostart.enable = true;
  #   portal = {
  #     config.common.default = "gnome";
  #     enable = true;
  #     wlr.enable = true;
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal-gnome
  #     ];
  #   };
  # };
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  zramSwap.enable = true;
  services = {
    udev.extraRules = ''
      KERNEL=="ntsync", MODE="0660", TAG+="uaccess"
    '';
    pulseaudio = {
      enable = false;
    };
    fwupd.enable = true;
    ollama = {
      enable = true;
      loadModels = [ "deepseek-r1:1.5b" ];
    };
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    avahi = {
    	enable = true;
    	nssmdns4 = true;
    	openFirewall = true;
    	publish = {
    		enable = true;
    		addresses = true;
    		workstation = true;
    	};
    };
    dbus.enable = true;
    blueman.enable = true;
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
    displayManager.gdm.enable = true;
    # xserver.displayManager.gdm.background = ../assets/wallpaper.png;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "makano";
    };
    upower.enable = true;
  };
}
