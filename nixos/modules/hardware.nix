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
    pulseaudio = {
      enable = false;
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}