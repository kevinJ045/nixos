{
  config,
  pkgs,
  lib,
  nixvim,
  ...
}:

{
  programs.neovide = {
    enable = false;
    settings = {
      font = {
        fork = lib.mkForce true;
        normal = lib.mkForce [ "FiraCode Nerd Font" ];
        size = lib.mkForce 14.0;
      };
    };
  };

  programs.helix = {
  	enable = true;
  	extraConfig = ''
      [editor.indent-guides]
      render = true
      
      [keys.normal]
      C-z = "@u"
      C-y = "@U"
      C-s = ":write!"
      C-q = ":quit!"
      C-tab = "@ga"
      C-p = ":e ."

      [editor.lsp]
      display-inlay-hints = true
      
      [keys.insert]
      C-z = "@u"
      C-y = "@U"
      C-tab = "@ga"
      C-c = ":clipboard-yank"
      C-v = ":clipboard-paste-replace"
      C-backspace = "@bd"
      C-del = "@wd"
      C-p = ":e ."
      C-s = ":write!"
      C-q = ":quit!"
  	'';
  };
}
