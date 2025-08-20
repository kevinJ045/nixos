{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      wifi.powersave = false;
    };
    wireless.iwd.enable = true;
    firewall = {
      # enable = false;
      checkReversePath = false;
      allowedTCPPorts = [
        20 21 22    # FTP and SSH
        3000 3001 5000  # Servers
        10000 10100     # Passive FTP range
        4242 52111 24800
        8290 4567 8821 4713
      ];
      allowedUDPPorts = [
      	4242 8290 4567
      	8821 24800
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
