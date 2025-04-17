{ config, pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./neovim.nix
    ./vscode.nix
    ./gh.nix
  ];
}