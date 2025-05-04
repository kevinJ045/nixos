{ config, pkgs, lib, nixvim, ... }:

{

  imports = [
  	nixvim.homeManagerModules.nixvim
  ];

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

  # programs.nixvim.package = nixvim;
  # programs.nixvim.enable = true;
  
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    

#     # === Core UI Options ===
    opts = {
      number = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      scrolloff = 3;
      wrap = false;
      mouse = "a";
      clipboard = "unnamedplus";
      splitbelow = true;
      splitright = true;
      signcolumn = "yes";
      termguicolors = true;
      guicursor = "n-v-c-i:block";
    };
# 
    globals = {
      mapleader = " ";
    };
# 
    keymaps = [
      # Undo/Redo
      { mode = "n"; key = "<C-z>"; action = ":u<CR>"; }
      { mode = "i"; key = "<C-z>"; action = "<C-o>:u<CR>"; }
      { mode = "n"; key = "<C-y>"; action = ":redo<CR>"; }
      { mode = "i"; key = "<C-y>"; action = "<C-o>:redo<CR>"; }
    
      # Select all
      { mode = "n"; key = "<C-a>"; action = "ggVGi"; }
      { mode = "i"; key = "<C-a>"; action = "<Esc>ggVG"; }
    
      # NvimTree toggle
      { mode = "n"; key = "<C-b>"; action = ":NvimTreeToggle<CR>"; }
    
      # Fuzzy find files
      { mode = "n"; key = "<C-p>"; action = ":Telescope find_files<CR>"; options = { noremap = true; }; }
    
      # Force quit and save
      { mode = "n"; key = "<C-q>"; action = ":q!<CR>"; }
      { mode = "i"; key = "<C-q>"; action = "<Esc>:q!<CR>"; }
      { mode = "n"; key = "<C-s>"; action = ":w!<CR>"; }
      { mode = "i"; key = "<C-s>"; action = "<Esc>:w!<CR>"; }
    
      # Tabs
      { mode = "n"; key = "<leader>t"; action = ":tabnext<CR>"; }
      { mode = "n"; key = "<leader>T"; action = ":tabprevious<CR>"; }
      { mode = "n"; key = "<C-S-Tab>"; action = ":tabnext<CR>"; }
    
      # Visual deletions
      { mode = "v"; key = "<BS>"; action = "d"; }
      { mode = "v"; key = "<Del>"; action = "d"; }
    
      # Clipboard interactions
      { mode = "v"; key = "<C-c>"; action = ''"+y''; }
      { mode = "n"; key = "<C-v>"; action = ''"+p''; }
      { mode = "v"; key = "<C-v>"; action = ''"+p''; }
      { mode = "v"; key = "<C-x>"; action = ''"+x''; }
      { mode = "i"; key = "<C-v>"; action = "<C-r>+"; }
    
      # Selection via Shift + arrows
      { mode = "n"; key = "<S-Left>"; action = "v"; }
      { mode = "n"; key = "<S-Right>"; action = "v"; }
      { mode = "n"; key = "<S-Up>"; action = "v"; }
      { mode = "n"; key = "<S-Down>"; action = "v"; }
    
      { mode = "n"; key = "<C-S-Left>"; action = "vbiw"; }
      { mode = "n"; key = "<C-S-Right>"; action = "veiw"; }
      { mode = "n"; key = "<C-S-Up>"; action = "v{k"; }
      { mode = "n"; key = "<C-S-Down>"; action = "v}j"; }
    
      { mode = "i"; key = "<S-Left>"; action = "<Esc>v"; }
      { mode = "i"; key = "<S-Right>"; action = "<Esc>v"; }
      { mode = "i"; key = "<S-Up>"; action = "<Esc>v"; }
      { mode = "i"; key = "<S-Down>"; action = "<Esc>v"; }
    
      { mode = "i"; key = "<C-S-Left>"; action = "<Esc>vbiw"; }
      { mode = "i"; key = "<C-S-Right>"; action = "<Esc>veiw"; }
      { mode = "i"; key = "<C-S-Up>"; action = "<Esc>v{k"; }
      { mode = "i"; key = "<C-S-Down>"; action = "<Esc>v}j"; }
    
      # Yank and paste with Ctrl+D
      { mode = "n"; key = "<C-d>"; action = "yyp"; options = { noremap = true; }; }
      { mode = "v"; key = "<C-d>"; action = "y`>p"; options = { noremap = true; }; }
      { mode = "i"; key = "<C-d>"; action = "<Esc>yyP`[A"; options = { noremap = true; silent = true; }; }
    
      # Visual indent
      { mode = "v"; key = "<S-Tab>"; action = "<gv"; options = { noremap = true; }; }
      { mode = "v"; key = "<Tab>"; action = ">gv"; options = { noremap = true; }; }
      { mode = "i"; key = "<S-Tab>"; action = "<Esc><gv`[A"; options = { noremap = true; }; }
    
      # Comment toggling (requires 'numToStr/Comment.nvim')
      { mode = "n"; key = "<C-_>"; lua = true; action = "function() require('Comment.api').toggle.linewise.current() end"; }
      { mode = "v"; key = "<C-_>"; lua = true; action = "function() require('Comment.api').toggle.linewise(vim.fn.visualmode()) end"; }
    
      # Match jump
      { mode = "n"; key = "<C-m>"; action = "%"; options = { noremap = true; }; }
      { mode = "v"; key = "<C-m>"; action = "%"; options = { noremap = true; }; }
      { mode = "i"; key = "<C-m>"; action = "<Esc>%i"; options = { noremap = true; }; }
    
      # ToggleTerm (requires toggleterm.nvim)
      { mode = "n"; key = "<C-`>"; action = "<cmd>ToggleTerm direction=vertical name=Terminal<CR>"; options = { noremap = true; silent = true; }; }
    
      # Fuzzy search in current buffer (requires telescope.nvim)
      { mode = "n"; key = "<C-f>"; lua = true; action = "function() require('telescope.builtin').current_buffer_fuzzy_find() end"; options = { noremap = true; }; }
    ];
# 
# 	colorschemes.catppuccin.enable = true;
# 
    plugins = {
      lualine.enable = true;
      treesitter = {
        enable = true;
        settings.indent.enable = true;
        settings.ensure_installed = "all";
      };
      treesitter-context.enable = true;

      telescope.enable = true;
      # telescope.extensions.project.enable = true;
      toggleterm.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
      nvim-tree.enable = true;
      bufferline = {
      	enable = true;
      	settings = {
      	  highlights = {
   	  	    fill = {
   	  	      bg = "#ffffff";
   	  	      fg = "#ff0000";
   	  	    };
   	  	    tab = {
   	  	      bg = "#ffffff";
   	  	      fg = "#ff0000";
   	  	    };
   	  	    tab_selected = {
   	  	      bg = "#ffffff";
  	  	      fg = "#ff0000";
   	  	    };
   	  	  };	
      	};
      };
      dashboard = {
      	enable = true;
		settings = {
		  config = {
		    footer = [
		      "Made with ❤️"
		    ];
		    header = [
		        "                    __                                 "
		        "                   /\\ \\                                "
		        "  ___ ___      __  \\ \\ \\'\\      __      ___     ___   "
		        "/' __` __`\\  /'__`\\ \\ \\ , <    /'__`\\  /' _ `\\  / __`\\ "
		        "/\\ \\/\\ \\/\\ \\/\\ \\L\\.\\_\\ \\ \\`\\`\\ /\\ \\L\\.\\_/\\ \\/\\ \\/\\ \\L\\ \\"
		        "\\ \\_\\ \\_\\ \\_\\ \\__/.\\_\\\\ \\_\\ \\_\\ \\__/.\\_\\ \\_\\ \\_\\ \\____/"
		        " \\/_/\\/_/\\/_/\\/__/\\/_/ \\/_/\\/_/\\/__/\\/_/\\/_/\\/_/\\/___/ "
		    ];
		    mru = {
		      limit = 10;
		    };
		    project = {
		      enable = true;
		    };
		    shortcut = [
		      {
		        action = {
		          __raw = "function(path) vim.cmd('Telescope find_files') end";
		        };
		        desc = "Files";
		        group = "Label";
		        icon = " ";
		        icon_hl = "@variable";
		        key = "f";
		      }
		      {
		        action = "Telescope project";
		        desc = "Projects";
   		        icon = " ";
		        group = "Label";
		        key = "p";
		      }
		    ];
		  };
		  theme = "hyper";
		};
      };
  #     snacks = {
  #     	enable = true;
		# settings = {
		#   bigfile = {
		#     enabled = true;
		#   };
		#   dashboard = {
		#   	enabled = true;
		#   };
		#   notifier = {
		#     enabled = true;
		#     timeout = 3000;
		#   };
		#   quickfile = {
		#     enabled = false;
		#   };
		#   statuscolumn = {
		#     enabled = false;
		#   };
		#   words = {
		#     debounce = 100;
		#     enabled = true;
		#   };
		# };
  #     };
      avante.enable = true;
      commentary.enable = true;
      fugitive.enable = true;
      gitgutter.enable = true;
      lightline.enable = true;
      lightline.settings = {
      	colorscheme = "catppuccin-mocha";
      };
      # sensible.enable = true;
      sleuth.enable = true;
      surround.enable = true;
      fzf-lua.enable = true;
      # vim-coffee-script.enable = true;
      

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        settings.mappingPresets = [ "insert" ];
      };

      luasnip.enable = true;

      lsp = {
        enable = true;

        servers = {
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;
          rust_analyzer = {
          	enable = true;
          	installCargo = true;
          	installRustc = true;
          };
          nil_ls.enable = true;
        };
      };

      lsp-format.enable = true;

      none-ls = {
        enable = true;
        sources = {
          formatting = {
            prettierd.enable = true;
            stylua.enable = true;
            # rustfmt.enable = true;
          };
        };
      };

      web-devicons.enable = true;
    };

    extraConfigLua = ''
      vim.opt.whichwrap:append {
		['<'] = true,
		['>'] = true,
		['['] = true,
		[']'] = true,
	    h = true,
	    l = true,
	  }
	  vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.g.lightline = {
        colorscheme = 'catppuccin-mocha'
      }
	  
      -- Custom function: MRU Tab Switching
      
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

      vim.keymap.set("i", "<S-Tab>", function()
        vim.api.nvim_feedkeys("yyP", "<gv", true)
        vim.api.nvim_feedkeys("i", "n", true)
      end, { noremap = true, silent = true })

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
       
       vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm direction=vertical name=Terminal<CR>", { noremap = true, silent = true })
       
       
	  
      -- Optional: require local plugins if available
      pcall(require, "avante_lib")
      pcall(function() require("avante").setup() end)
    '';
  };

}
