{ config, pkgs, lib, ... }:

{
  imports = [
    ./wofi.nix
    ./fuzzel.nix
    ./kando.nix
  ];
}
