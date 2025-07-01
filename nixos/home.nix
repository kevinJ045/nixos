{ config, pkgs, lib, ... }:

{
  imports = [
    ./home/packages.nix
    ./home/programs
    ./home/services
    ./home/desktop
    ./home/theme.nix
    ./home/cilestia.nix
  ];

  home = {
    username = "makano";
    homeDirectory = "/home/makano";
    stateVersion = "23.11";
  };

  home.preferXdgDirectories = true;
  programs.home-manager.enable = true;
}
