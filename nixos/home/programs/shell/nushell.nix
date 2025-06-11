{ config, pkgs, lib, ... }:

{
  programs.nushell = {
    enable = true;
    envFile = ''
		$env.PATH = '$PATH:$HOME/.rew/bin:$HOME/exploit/bin:$HOME/portables/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.local/share/scripts/bin'
    '';
  };
}
