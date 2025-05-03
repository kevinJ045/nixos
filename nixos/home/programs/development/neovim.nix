{ config, pkgs, lib, ... }:

{


  programs.neovide = {
  	enable = true;
  	settings = {
  		font = {
                        fork = true;
	  		normal = ["FiraCode Nerd Font"];
	  		size = 11.0;
	  	};
  	};
  };
  
  programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = ''
        require('nvim-treesitter.configs').setup {
          auto_install = false,
          ignore_install = {},
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true
          },
        }

        local on_attach = function(client, bufnr)
          require("lsp-format").on_attach(client, bufnr)
        end

        require("lsp-format").setup{}
        require('lspconfig').ts_ls.setup{ on_attach = on_attach }
        require('lspconfig').eslint.setup{ on_attach = on_attach }
        require('lspconfig').jdtls.setup{ on_attach = on_attach }
        require('lspconfig').svelte.setup{ on_attach = on_attach }
        require('lspconfig').bashls.setup{ on_attach = on_attach }
        require('lspconfig').pyright.setup{ on_attach = on_attach }
        require('lspconfig').nixd.setup{ on_attach = on_attach }
        require('lspconfig').clangd.setup{ on_attach = on_attach }
        require('lspconfig').html.setup{ on_attach = on_attach }
		require("lspconfig").rust_analyzer.setup({
		  settings = {
		    ["rust-analyzer"] = {
		      cargo = { allFeatures = true }
		    }
		  }
		})
	

        vim.keymap.set('n', '<C-f>', require('telescope.builtin').current_buffer_fuzzy_find, { noremap = true, silent = true })

        local prettier = {
            formatCommand = [[prettier --stdin-filepath ''${INPUT} ''${--tab-width:tab_width}]],
            formatStdin = true,
        }
        require("lspconfig").efm.setup {
            on_attach = on_attach,
            init_options = { documentFormatting = true },
            settings = {
                languages = {
                    typescript = { prettier },
                    html = { prettier },
                    javascript = { prettier },
                    json = { prettier },
                },
            },
        }
        
        require("nvim-tree").setup()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local luasnip = require('luasnip')
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require('cmp')
        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
            ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
            -- C-b (back) C-f (forward) for snippet placeholder navigation.
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-z>'] = cmp.mapping(function()
            	vim.cmd('undo')
            end, { 'i', 's' }),
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          },
        }

        local mru_tabs = {}
        local current_tab = vim.api.nvim_get_current_tabpage()
        
        vim.api.nvim_create_autocmd("TabLeave", {
            callback = function()
                current_tab = vim.api.nvim_get_current_tabpage()
            end
        })
        
        vim.api.nvim_create_autocmd("TabEnter", {
            callback = function()
                local new_tab = vim.api.nvim_get_current_tabpage()
                if new_tab ~= current_tab then
                    -- Remove if already in list
                    for i, tab in ipairs(mru_tabs) do
                        if tab == new_tab then
                            table.remove(mru_tabs, i)
                            break
                        end
                    end
                    table.insert(mru_tabs, 1, current_tab)
                    current_tab = new_tab
                end
            end
        })
        
        function SwitchToLastTab()
            if #mru_tabs > 0 then
                vim.api.nvim_set_current_tabpage(mru_tabs[1])
            end
        end
        
        vim.keymap.set('n', '<C-Tab>', SwitchToLastTab, { noremap = true, silent = true })
      
        local function delete_word_before_cursor()
          local col = vim.fn.col('.')
          if col == 1 then return end
          vim.cmd('normal! db')
        end

        local function delete_word_after_cursor()
          vim.cmd('normal! dw')
        end

        vim.keymap.set('i', '<C-Del>', delete_word_after_cursor, { noremap = true })
        vim.keymap.set('i', '<C-BS>', delete_word_before_cursor, { noremap = true })
      
        vim.opt.autoindent = true
        vim.opt.smartindent = true
        vim.opt.formatoptions:append("r")
        
        vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
        vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
        vim.keymap.set("i", "<S-Tab>", function()
          vim.api.nvim_feedkeys("yyP", "<gv", true)
          vim.api.nvim_feedkeys("i", "n", true)
        end, { noremap = true, silent = true })
        
   		vim.keymap.set("n", "<C-_>", function() require("Comment.api").toggle.linewise.current() end, { noremap = true, silent = true })
        vim.keymap.set("v", "<C-_>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true })
        
        vim.keymap.set("n", "<C-m>", "%", { noremap = true, silent = true })
        vim.keymap.set("v", "<C-m>", "%", { noremap = true, silent = true })
        vim.keymap.set("i", "<C-m>", "<Esc>%i", { noremap = true, silent = true })

        require("Comment").setup()

        vim.keymap.set("n", "<C-d>", 'yyp', { noremap = true, silent = true }) -- normal mode: yank and paste line below
        vim.keymap.set("v", "<C-d>", 'y`>p', { noremap = true, silent = true }) -- visual mode: yank selection
        
        vim.keymap.set("i", "<C-d>", function()
          vim.api.nvim_feedkeys("yyP", "n", true)
          vim.api.nvim_feedkeys("i", "n", true)
        end, { noremap = true, silent = true })

        require('treesitter-context').setup({
          enable = true,   -- Enable the plugin
          max_lines = 0,   -- Maximum number of lines to display for context
          min_window_height = 0,  -- Minimum window height before the context appears
        })

        require("ibl").setup()
	require("toggleterm").setup()
		
        vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm direction=vertical name=Terminal<CR>", { noremap = true, silent = true })
        

        require('dashboard').setup {
          theme = 'doom',
          config = {
            week_header = {
                enable = true,
            },
            shortcut = {
              {
                desc = " Projects",
                key = "p",
                action = "Telescope find_files cwd='",
              },
            },
            project = { enable = true, limit = 8, icon = ' ', label = 'Project', action = 'Telescope find_files cwd=' },
          },
        }

      '';
      extraConfig = ''
        set guicursor=n-v-c-i:block
        set nowrap
        colorscheme catppuccin-mocha
        let g:lightline = {
              \ 'colorscheme': 'catppuccin_mocha',
              \ }
        map <leader>ac :lua vim.lsp.buf.code_action()<CR>
        set ts=2
        set undofile
        set undodir=$HOME/.vim/undodir
        set number
        set whichwrap+=<,h
        set whichwrap+=>,l
        set whichwrap+=[,]
        
        nnoremap <c-z> :u<CR>      
        inoremap <c-z> <c-o>:u<CR>
        nnoremap <c-y> :redo<CR>
        inoremap <c-y> <c-o>:redo<CR>                        
        inoremap <C-BS> <C-w>
        nnoremap <C-a> ggVGi

        inoremap <C-a> <Esc>ggVG
        nnoremap <C-b> :NvimTreeToggle<CR>
        nnoremap <C-p> :Files<CR>
        nnoremap <C-q> :q!<CR>
        inoremap <C-q> <Esc>:q!<CR>
        nnoremap <C-s> :w!<CR>
        inoremap <C-s> <Esc>:w!<CR>

        let mapleader = " "

        nnoremap <leader>t :tabnext<CR>
        nnoremap <leader>T :tabprevious<CR>
        nnoremap <C-S-Tab> :tabnext<CR>


        vnoremap <BS> d
        vnoremap <Del> d

        vnoremap <C-c> "+y
        nnoremap <C-v> "+p
        vnoremap <C-v> "+p
        vnoremap <C-x> "+x
        inoremap <C-v> <C-r>+
                
        nnoremap <S-Left> v
        nnoremap <S-Right> v
        nnoremap <S-Up> v
        nnoremap <S-Down> v

        nnoremap <C-S-Left> vbiw
        nnoremap <C-S-Right> veiw
        nnoremap <C-S-Up> v{k
        nnoremap <C-S-Down> v}j

        inoremap <S-Left> <Esc>v
        inoremap <S-Right> <Esc>v
        inoremap <S-Up> <Esc>v
        inoremap <S-Down> <Esc>v
        
        inoremap <C-S-Left> <Esc>vbiw
        inoremap <C-S-Right> <Esc>veiw
        inoremap <C-S-Up> <Esc>v{k
        inoremap <C-S-Down> <Esc>v}j

        function! s:start_delete(key)
            let l:result = a:key
            if !s:deleting
                let l:result = "\<C-G>u".l:result
            endif
            let s:deleting = 1
            return l:result
        endfunction

        function! s:check_undo_break(char)
            if s:deleting
                let s:deleting = 0
                call feedkeys("\<BS>\<C-G>u".a:char, 'n')
            endif
        endfunction

        augroup smartundo
            autocmd!
            autocmd InsertEnter * let s:deleting = 0
            autocmd InsertCharPre * call s:check_undo_break(v:char)
        augroup END

        inoremap <expr> <BS> <SID>start_delete("\<BS>")
        inoremap <expr> <C-W> <SID>start_delete("\<C-W>")
        inoremap <expr> <C-U> <SID>start_delete("\<C-U>")
      '';
      plugins = [
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.lsp-format-nvim
        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.cmp_luasnip
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.friendly-snippets
        pkgs.vimPlugins.catppuccin-vim
        pkgs.vimPlugins.commentary
        pkgs.vimPlugins.fugitive
        pkgs.vimPlugins.gitgutter
        pkgs.vimPlugins.lightline-vim
        pkgs.vimPlugins.plenary-nvim
        pkgs.vimPlugins.sensible
        pkgs.vimPlugins.sleuth
        pkgs.vimPlugins.surround
        pkgs.vimPlugins.todo-comments-nvim
        pkgs.vimPlugins.fzf-vim
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        pkgs.vimPlugins.vim-coffee-script
        pkgs.vimPlugins.nvim-tree-lua
        pkgs.vimPlugins.telescope-nvim
        # pkgs.vimPlugins.telescope-project-nvim
        pkgs.vimPlugins.comment-nvim
        pkgs.vimPlugins.nvim-treesitter
        pkgs.vimPlugins.nvim-treesitter-context
        pkgs.vimPlugins.indent-blankline-nvim
        pkgs.vimPlugins.toggleterm-nvim
        pkgs.vimPlugins.dashboard-nvim
        # pkgs.vimPlugins.augment-vim 
      ];
    };
}
