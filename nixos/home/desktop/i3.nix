{ config, pkgs, lib, ... }:


{
    xsession.windowManager.i3 = {
  	enable = true;
  	config = rec {
  		modifier = "Mod4";
  	};
  };
}