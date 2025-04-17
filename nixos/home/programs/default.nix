{ config, pkgs, lib, ... }:

{
  imports = [
    ./shell
    ./development
    ./terminal
    ./utils
  ];
}