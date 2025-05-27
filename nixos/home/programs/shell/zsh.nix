{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "node"
        "python"
        "ssh"
        "vscode"
      ];
      theme = "robbyrussell";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions.src;
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k.src;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting.src;
      }
    ];
    localVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
    initContent = ''
      export PATH="$PATH:$HOME/exploit/bin:$HOME/portables/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.local/share/scripts/bin"
      export MICRO_TRUECOLOR=1

      alias game64="WINEPREFIX=/home/makano/Games/wine64 wine64"
      alias game32="WINEPREFIX=/home/makano/Games/wine32 wine"

      bindkey '^H' backward-kill-word

      alias -- exai='exa --icons'
      alias -- la='exai -a'
      alias -- ll='exai -l'
      alias -- lla='exai -la'
      alias -- ls=exai
      alias -- lt='exai --tree'
    '';
  };
}
