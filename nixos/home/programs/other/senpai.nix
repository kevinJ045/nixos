{ config, pkgs, lib, ... }:

{
    programs.senpai = {
  	enable = true;
  	config = {
  		address = "irc.libera.chat:6697";
  		nickname = "makano";
  	};
  };
}