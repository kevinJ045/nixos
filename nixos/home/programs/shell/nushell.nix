{ config, pkgs, lib, ... }:

{
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.nushell = {
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
      carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
       show_banner: false,
       completions: {
       case_sensitive: false
       quick: true
       partial: true
       algorithm: "fuzzy"
       external: {
	   enable: true 
	   max_results: 100 
	   completer: $carapace_completer # check 'carapace_completer' 
	 }
       }
      } 
      $env.PATH = ($env.PATH | 
      split row (char esep) |
      prepend /home/myuser/.apps |
      append /usr/bin/env
      )
    '';
  };
}
