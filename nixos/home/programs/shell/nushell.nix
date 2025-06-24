{ config, pkgs, lib, ... }:

{
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
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
       },
       keybindings: [
         {
           name: backward_kill_word
           modifier: control
           keycode: char_h
           mode: [emacs, vi_insert]
           event: [
             { edit: BackspaceWord }
           ]
         }
       ]
      } 
      $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/makano/.rew/bin |
        prepend /home/makano/exploit/bin |
        prepend /home/makano/portables/bin |
        prepend /home/makano/.local/bin |
        prepend /home/makano/.local/share/scripts/bin |
        prepend /home/makano/.npm-global/bin
      )
    '';
  };
}
