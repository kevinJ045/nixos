
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # Generated hardware config
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/services.nix
    ./modules/virtualisation.nix
    ./modules/users.nix
    ./modules/environment.nix
    ./modules/security.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = false;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
  };

  time.timeZone = "Africa/Addis_Ababa";
  system.stateVersion = "23.11";
}
