{ config, pkgs, lib, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = '''';
    profileExtra = ''
      PATH="$HOME/.local/bin:$PATH"
      export PATH
    '';
  };
}