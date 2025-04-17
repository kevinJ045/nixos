{ config, lib, pkgs, ... }:

{
  security = {
    polkit.enable = true;
    pam.services = {
      swaylock = {};
      systemd-run0 = {};
    };
    rtkit.enable = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "sway-session.target" "hyprland-session.target" "graphical-session.target" ];
    wants = [ "sway-session.target" "hyprland-session.target" "graphical-session.target" ];
    after = [ "sway-session.target" "hyprland-session.target" "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}