{ config, pkgs, lib, ... }:

{
  imports = [
    ./wofi.nix
    ./kando.nix
  ];
}