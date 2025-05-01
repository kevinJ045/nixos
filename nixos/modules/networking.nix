{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;
    firewall = {
      # enable = false;
      checkReversePath = false;
      allowedTCPPorts = [
        20 21 22    # FTP and SSH
        3000 3001 5000  # Servers
        10000 10100     # Passive FTP range
      ];
      allowedTCPPortRanges = [
        { from = 10000; to = 10100; }
        { from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
}
