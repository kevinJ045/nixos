{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./bash.nix
    ./fzf.nix
    ./tmux.nix
    ./starship.nix
  ];
}