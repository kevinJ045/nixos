{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "makanobush@gmail.com";
    userName = "makano";
    # signing = {
    #   key = "";
    #   signByDefault = true;
    # };
    extraConfig = {
      credential = {
        helper = "store";
      };
    };
  };
}