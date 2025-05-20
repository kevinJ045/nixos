{ config, pkgs, lib, ... }:

{
  imports = [
    ./kitty.nix
    ./alacritty.nix
    ./foot.nix
    ./micro.nix
    ./ghostty.nix
  ];
}
