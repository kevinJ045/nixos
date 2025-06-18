{
  config,
  pkgs,
  lib,
  nixvim,
  mnw,
  ...
}:

{
  home = {
    packages = with pkgs; [
      (mnw.lib.wrap pkgs {
        neovim = pkgs.neovim-unwrapped;
        aliases = [
          "vi"
          "vim"
        ];
        initLua = ''
          require('codebam')
        '';
        providers = {
          ruby.enable = false;
          python3.enable = false;
        };
        plugins = {
          dev.codebam = {
            pure = ./nvim;
          };
          start = with pkgs.vimPlugins; [
            avante-nvim
            blink-cmp
            catppuccin-vim
            commentary
            conform-nvim
            flash-nvim
            friendly-snippets
            fugitive
            gitsigns-nvim
            lazydev-nvim
            lualine-nvim
            luasnip
            nvim-autopairs
            nvim-treesitter.withAllGrammars
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
      })
    ];
  };
}
