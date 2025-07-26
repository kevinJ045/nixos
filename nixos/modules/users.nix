{ config, lib, pkgs, ... }:

{
  users.users.makano = {
    isNormalUser = true;
    home = "/home/makano";
    description = "Makano";
    extraGroups = ["wheel" "udisks2" "storage" "bluetooth" "input" "libvirtd" "kvm" "networkmanager" "audio" "sound" "video"];
    packages = with pkgs; [
      flatpak
      godot_4
      eza
    ];
    shell = pkgs.nushell;
    # shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
