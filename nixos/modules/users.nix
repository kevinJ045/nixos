{ config, lib, pkgs, ... }:

{
  users.users.makano = {
    isNormalUser = true;
    home = "/home/makano";
    description = "Makano";
    extraGroups = ["wheel" "bluetooth" "input" "libvirtd" "kvm" "networkmanager" "audio" "sound" "video"];
    packages = with pkgs; [
      flatpak
      godot_4
      eza
    ];
    shell = pkgs.nushell;
  };

  programs.zsh.enable = true;
}
