{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./bash.nix
    ./nushell.nix
    ./fzf.nix
    ./tmux.nix
    ./starship.nix
  ];
}
