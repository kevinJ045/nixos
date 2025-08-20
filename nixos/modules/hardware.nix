{ config, lib, pkgs, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.gamescope-wsi ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    enableAllFirmware = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    extraConfig.pipewire-pulse = {
    "99-network-tcp" = {
      "pulse.cmd" = [
          {
            cmd = "load-module";
            args = "module-native-protocol-tcp auth-ip-acl=192.168.100.0/24 auth-anonymous=1";
          }
        ];
      };
    };    
    jack.enable = true;
    wireplumber.enable = true;
  };
}
