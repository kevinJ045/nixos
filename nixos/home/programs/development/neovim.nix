{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{

  home.packages = with pkgs; [
    (inputs.mnw.lib.wrap pkgs {
      neovim = pkgs.neovim-unwrapped;
      aliases = [
        "vi"
        "vim"
      ];
      initLua = ''
        require('makano')
      '';
      providers = {
        ruby.enable = false;
        python3.enable = false;
      };
      plugins = {
        dev.codebam = {
          pure = ../../../nvim;
        };
        start = with pkgs.vimPlugins; [
          avante-nvim
          blink-cmp
          blink-cmp-copilot
          catppuccin-vim
          commentary
          conform-nvim
          copilot-lua
          friendly-snippets
          gitsigns-nvim
          lazydev-nvim
          lualine-nvim
          luasnip
          neogit
          nvim-autopairs
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          nvim-web-devicons
          oil-nvim
          plenary-nvim
          sensible
          sleuth
          surround
          telescope-nvim
          todo-comments-nvim
        ];
      };
      extraLuaPackages = ps: [ ps.jsregexp ];
      extraBinPath = with pkgs; [
        bash-language-server
        nil
        nixd
      ];
    })
  ];

  programs.neovide = {
    enable = true;
    settings = {
      font = {
        fork = lib.mkForce true;
        normal = lib.mkForce [ "FiraCode Nerd Font" ];
        size = lib.mkForce 14.0;
      };
    };
  };
}
