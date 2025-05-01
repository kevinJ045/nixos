{ config, pkgs, lib, ... }:

{
  # services.mako = {
  #   enable = true;
  #   layer = "overlay";
  #   font = "Noto Sans";
  #   defaultTimeout = 5000;
  # };

  services.swaync = {
  	enable = true;
  };
}
