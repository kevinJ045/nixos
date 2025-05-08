{ config, lib, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "usbcore.autosuspend=-1" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    extraModprobeConfig = ''
      options usbcore use_both_schemes=y
    '';
  };
}
