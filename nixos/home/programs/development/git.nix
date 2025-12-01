{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    # userEmail = "makanobush@gmail.com";
    # userName = "makano";
    # signing = {
    #   key = "";
    #   signByDefault = true;
    # };
    settings = {
      user = {
        name = "makano";
        email = "makanobush@gmail.com";
      };
      credential = {
        helper = "store";
      };
    };
  };
}
