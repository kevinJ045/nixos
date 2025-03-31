{ config, pkgs, lib, ... }:

let
  catppuccin-gtk-theme = import ./catppuccin-gtk-theme.nix {
  	# inherit pkgs;
    lib = pkgs.lib;
    stdenv = pkgs.stdenv;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    gtk-engine-murrine = pkgs.gtk-engine-murrine;
    jdupes = pkgs.jdupes;
    sassc = pkgs.sassc;
    accent = ["default"];  # You can adjust these based on your preference
    shade = "dark";
    size = "standard";
  };
in
{
  home.username = "makano";
  home.homeDirectory = "/home/makano";

      home.packages = with pkgs; [
      (writeShellScriptBin "spaste" ''
        ${curl}/bin/curl -X POST --data-binary @- https://p.seanbehan.ca
      '')
      (writeShellScriptBin "nvimdiff" ''
        nvim -d $@
      '')
      (pass.withExtensions (subpkgs: with subpkgs; [
        pass-audit
        pass-otp
        pass-genphrase
      ]))
      aerc
      bat
      clang-tools
      pkg-config
      ctags
      efm-langserver
      eza
      inter
      grim
      jdt-language-server
      nodejs
      nodePackages.bash-language-server
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.prettier
      pylint
      pyright
      python3
      rcm
      ripgrep
      slurp
      vscode-langservers-extracted
      weechat
    ];

  xsession.windowManager.i3 = {
  	enable = true;
  	config = rec {
  		modifier = "Mod4";
  	};
  };


  wayland.windowManager.hyprland = {
  	enable = true;
  	settings = {
  		"$asrcPath" = "~/.config/scripts";
  		"$mainMod" = "SUPER";
  		"$term" = "foot";
  		"$editor" = "code --disable-gpu";
  		"$file" = "nautilus";
  		"$browser" = "chromium";
  		"exec-once" = [
  			"$asrcPath/lowbattery.sh"
  			"waybar"
  			"blueman-applet"
  			"nm-applet --indicator"
  			"mako"
  			"wl-paste --type text --watch cliphist store"
  			"wl-paste --type image --watch cliphist store"
  			"hyprpaper"
  		];
  		exec = [
  			# Cursor
  			"hyprctl setcursor GoogleDot-Black 12"

  			# HyprFonts
  			"gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Bold'"
  			"gsettings set org.gnome.desktop.interface document-font-name 'JetBrains Mono Bold'"
  			"gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Bold'"
  			"gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'"
  			"gsettings set org.gnome.desktop.interface font-hinting 'full'"
  		];
  		env = [
  			"XDG_DESKTOP_DIR,$HOME/Desktop"
  			"XDG_DOWNLOAD_DIR,$HOME/Downloads"
  			"XDG_TEMPLATES_DIR,$HOME/Templates"
  			"XDG_PUBLICSHARE_DIR,$HOME/Public"
  			"XDG_DOCUMENTS_DIR,$HOME/Documents"
  			"XDG_MUSIC_DIR,$HOME/Music"
  			"XDG_PICTURES_DIR,$HOME/Pictures"
  			"XDG_VIDEOS_DIR,$HOME/Videos"
  			"XDG_CURRENT_DESKTOP,Hyprland"
  			"XDG_SESSION_TYPE,wayland"
  			"XDG_SESSION_DESKTOP,Hyprland"
  			# "QT_QPA_PLATFORM,wayland"
  			# "QT_STYLE_OVERRIDE,kvantum"
  			# "QT_QPA_PLATFORMTHEME,qt6ct"
  			"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
  			"QT_AUTO_SCREEN_SCALE_FACTOR,1"
  			"MOZ_ENABLE_WAYLAND,1"
  			"XCURSOR_THEME,GoogleDot-Black"
  		];
  		input = {
  		    kb_layout = "us";
  		    follow_mouse = 1;
  		    natural_scroll = "yes";
  		    touchpad = {
  		        natural_scroll = "yes";
  		        disable_while_typing = "no";
  		    };
  		    sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
  		    force_no_accel = 1;
  		};
  		gestures = {
  		    workspace_swipe = true;
  		    workspace_swipe_fingers = 3;
  		};
  		dwindle = {
  		    pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
  		    preserve_split = "yes"; # you probably want this
  		};
  		# master = {
  		    # new_is_master = true;
  		# };
  		misc = {
  		    vrr = 0;
  		    disable_hyprland_logo = true;
  		    disable_splash_rendering = true;
  		    always_follow_on_dnd = true;
  		};
  		animations = {
  		    enabled = "yes";
  		    bezier = [
  		    	"wind, 0.05, 0.9, 0.1, 1.05"
  		    	"winIn, 0.1, 1.1, 0.1, 1.1"
  		    	"winOut, 0.3, -0.3, 0, 1"
  		    	"liner, 1, 1, 1, 1"
  		    ];
  		    animation = [
  		    	"windows, 1, 6, wind, slide"
  		    	"windowsIn, 1, 6, winIn, slide"
  		    	"windowsOut, 1, 5, winOut, slide"
  		    	"windowsMove, 1, 5, wind, slide"
  		    	"borderangle, 1, 30, liner, loop"
  		    	"fade, 1, 10, default"
  		    	"workspaces, 1, 5, wind"
  		    ];
  		};
  		bind = [
  			"$mainMod, Q, killactive"
  			"$mainMod, delete, exit, "
  			"$mainMod, W, togglefloating, "
  			"$mainMod, G, togglegroup, "
  			"$mainMod, F, fullscreen, "
  			"$mainMod, L, exec, swaylock "
  			"$mainMod, backspace, exec, $asrcPath/logoutlaunch.sh 1 "
  			
  			''$mainMod SHIFT, P, exec, foot -e sh -c "hyprctl activewindow && read"''
  			
  			"$mainMod, T, exec, $term  "
  			"$mainMod, Z, exec, $file "
  			"$mainMod, C, exec, $editor "
  			"$mainMod, B, exec, $browser "
  			"$CONTROL SHIFT, ESCAPE, exec, $asrcPath/sysmonlaunch.sh  "
  			
  			"$mainMod SHIFT, B, exec, pkill waybar -SIGUSR1"
  			
  			"$mainMod, D, exec, pkill -x wofi || wofi"
  			"$mainMod, tab, workspace, previous"
  			
  			"$mainMod, P, exec, $asrcPath/screenshot.sh p "
  			"$mainMod CTRL, P, exec, $asrcPath/screenshot.sh sf "
  			"$mainMod ALT, P, exec, sh $asrcPath/screenshot.sh m "
  			" , print, exec, $asrcPath/screenshot.sh s  "
  			# '' ,print, exec, kitty -e sh -c "cat $srcPath/screenshot.sh && read -p '$srcPath/screenshot.sh' -r"''
  			
  			
  			"$mainMod ALT, G, exec, $asrcPath/gamemode.sh "
  			"$mainMod, R, exec, pkill -x wmenu-run || ${pkgs.wmenu}/bin/wmenu-run -i -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4"
  			"$mainMod, V, exec, pkill -x rofi || $ascrPath/cliphist.sh c  "
  			
  			"$mainMod, left, movefocus, l"
  			"$mainMod, right, movefocus, r"
  			"$mainMod, up, movefocus, u"
  			"$mainMod, down, movefocus, d"
  			"ALT, Tab, movefocus, d"
  			
  			
  			"$mainMod, 1, workspace, 1"
  			"$mainMod, 2, workspace, 2"
  			"$mainMod, 3, workspace, 3"
  			"$mainMod, 4, workspace, 4"
  			"$mainMod, 5, workspace, 5"
  			"$mainMod, 6, workspace, 6"
  			"$mainMod, 7, workspace, 7"
  			"$mainMod, 8, workspace, 8"
  			"$mainMod, 9, workspace, 9"
  			"$mainMod, 0, workspace, 10"
  			
  			
  			"$mainMod CTRL, right, workspace, r+1 "
  			"$mainMod CTRL, left, workspace, r-1"
  			
  			"$mainMod CTRL, down, workspace, empty "
  			"$mainMod SHIFT, 1, movetoworkspace, 1"
  			"$mainMod SHIFT, 2, movetoworkspace, 2"
  			"$mainMod SHIFT, 3, movetoworkspace, 3"
  			"$mainMod SHIFT, 4, movetoworkspace, 4"
  			"$mainMod SHIFT, 5, movetoworkspace, 5"
  			"$mainMod SHIFT, 6, movetoworkspace, 6"
  			"$mainMod SHIFT, 7, movetoworkspace, 7"
  			"$mainMod SHIFT, 8, movetoworkspace, 8"
  			"$mainMod SHIFT, 9, movetoworkspace, 9"
  			"$mainMod SHIFT, 0, movetoworkspace, 10"
  			
  			"$mainMod CTRL ALT, right, movetoworkspace, r+1"
  			"$mainMod CTRL ALT, left, movetoworkspace, r-1"
  			
  			
  			"$mainMod SHIFT $CONTROL, left, movewindow, l"
  			"$mainMod SHIFT $CONTROL, right, movewindow, r"
  			"$mainMod SHIFT $CONTROL, up, movewindow, u"
  			"$mainMod SHIFT $CONTROL, down, movewindow, d"
  			
  			
  			"$mainMod, mouse_down, workspace, e+1"
  			"$mainMod, mouse_up, workspace, e-1"
  			
  			
  			"$mainMod ALT, S, movetoworkspacesilent, special"
  			"$mainMod, S, togglespecialworkspace,"
  			
  			
  			"$mainMod, J, togglesplit, "
  			
  			
  			"$mainMod ALT, 1, movetoworkspacesilent, 1"
  			"$mainMod ALT, 2, movetoworkspacesilent, 2"
  			"$mainMod ALT, 3, movetoworkspacesilent, 3"
  			"$mainMod ALT, 4, movetoworkspacesilent, 4"
  			"$mainMod ALT, 5, movetoworkspacesilent, 5"
  			"$mainMod ALT, 6, movetoworkspacesilent, 6"
  			"$mainMod ALT, 7, movetoworkspacesilent, 7"
  			"$mainMod ALT, 8, movetoworkspacesilent, 8"
  			"$mainMod ALT, 9, movetoworkspacesilent, 9"
  			"$mainMod ALT, 0, movetoworkspacesilent, 10"
  		];
  		bindm = [
  			"$mainMod, mouse:272, movewindow"
  			"$mainMod, mouse:273, resizewindow"
  		];
  		binde = [
  			"$mainMod SHIFT, right, resizeactive, 30 0"
  			"$mainMod SHIFT, left, resizeactive, -30 0"
  			"$mainMod SHIFT, up, resizeactive, 0 -30"
  			"$mainMod SHIFT, down, resizeactive, 0 30"
  		];
  		bindel = [
  			", XF86AudioLowerVolume, exec, $asrcPath/volumecontrol.sh -o d "
  			", XF86AudioRaiseVolume, exec, $asrcPath/volumecontrol.sh -o i "
  			", XF86MonBrightnessUp, exec, $asrcPath/brightnesscontrol.sh i "
  			", XF86MonBrightnessDown, exec, $asrcPath/brightnesscontrol.sh d "
  		];
  		bindl = [
  			" , XF86AudioMute, exec, $asrcPath/volumecontrol.sh -o m "
  			" , XF86AudioMicMute, exec, $asrcPath/volumecontrol.sh -i m "
  			" , XF86AudioPlay, exec, playerctl play-pause"
  			" , XF86AudioPause, exec, playerctl play-pause"
  			" , XF86AudioNext, exec, playerctl next"
  			" , XF86AudioPrev, exec, playerctl previous"
  			" , switch:on:Lid Switch, exec, $asrcPath/lock.sh"
  		];
  		windowrulev2 = [
  			"opacity 0.80 0.70,class:^(nm-applet)$"
  			
  			"float,class:^(Rofi)$"
  			"float,class:^(qt5ct)$"
  			"float,class:^(nwg-look)$"
  			"float,class:^(org.kde.ark)$"
  			"float,class:^(Signal)$ #Signal-Gtk"
  			"float,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk"
  			"float,class:^(app.drey.Warp)$ #Warp-Gtk"
  			"float,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt"
  			"float,class:^(yad)$ #Protontricks-Gtk"
  			"float,class:^(eog)$ #Imageviewer-Gtk"
  			"float,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk"
  			"float,class:^(pavucontrol)$"
  			"float,class:^(blueman-manager)$"
  			"float,class:^(nm-applet)$"
  			"float,class:^(nm-connection-editor)$"
  			"float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
  		];
  		decoration = {
  		    dim_special = 0.3;
  		    blur = {
  		    	enabled = "no";
  		        special = true;
  		    };
  		    rounding = 10;
  		};
  		general = {
  		    border_size = 0;
  		};
  		binds = {
  			workspace_back_and_forth = "yes";
  			allow_workspace_cycles = "yes";
  		};
  		debug = {
  			disable_logs = false;
  		};
  	};
  };
  
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
	bindgesture swipe:right workspace prev
	bindgesture swipe:left workspace next
	
	for_window [app_id="zenity"] floating enable
	'';
	wrapperFeatures = {
		base = true;
		gtk = true;
    };
    config = rec {
      startup = [
      	{ command = "/home/makano/.config/scripts/lowbattery.sh"; }
      	{ command = "blueman-applet"; }
      	{ command = "nm-applet --indicator"; }
      	{ command = "nm-applet --indicator"; }
      	{ command = "wl-paste --type text --watch cliphist store"; }
      	{ command = "wl-paste --type image --watch cliphist store"; }
      ];
      modifier = "Mod4";
      terminal = "foot";
      menu = "pkill -x wmenu-run || ${pkgs.wmenu}/bin/wmenu-run -i -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4";
      fonts = {
        names = [ "JetBrains Mono" "FontAwesome" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };
      output = {
        "*" = {
          bg = "${builtins.fetchurl { url = "https://raw.githubusercontent.com/Sahil-958/walls/refs/heads/main/hyprdots/Catppuccin-Mocha/cat_leaves.png"; sha256 = "1894y61nx3p970qzxmqjvslaalbl2skj5sgzvk38xd4qmlmi9s4i"; }} fill";
          # bg = "/home/makano/.config/background fill"; # "${builtins.fetchurl { url = "https://images.hdqwalls.com/download/1/beach-seaside-digital-painting-4k-05.jpg"; sha256 = "2877925e7dab66e7723ef79c3bf436ef9f0f2c8968923bb0fff990229144a3fe"; }} fill";
        };
      };
      bars = [{
        command = "waybar";#"sh -c 'pgrep -x waybar > /dev/null || waybar &'";
      }];
      window = {
        titlebar = false;
        border = 0;
        hideEdgeBorders = "smart";
      };
      input = {
      	"*" = {
      		dwt = "disabled";
      		tap = "enabled";
      		natural_scroll = "enabled";
      		pointer_accel = "0";
      		# accel_profile = "flat";
      	};
      };
      floating = {
        titlebar = false;
        border = 0;
      };
      gaps = {
        inner = 6;
        smartGaps = false;
      };
      focus.followMouse = true;
      workspaceAutoBackAndForth = true;
      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;  in lib.mkOptionDefault {
        "${modifier}+b" = "exec chromium";
        "${modifier}+c" = "exec code";
        "${modifier}+t" = "exec foot";
        
        "${modifier}+l" = "exec swaylock";
        
        "${modifier}+Tab" = "workspace back_and_forth";
        "${modifier}+Shift+p" = ''
          exec swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | {app_id, pid, name, id, shell, window}' | jq -r 'to_entries[] | "\(.key | ascii_upcase)\t\n\(.value)"' | zenity --list --title="Window Properties" --column="Field" --column="Value" --width=400 --height=300
        '';
        
        "${modifier}+Shift+b" = "exec pkill -SIGUSR1 waybar";
        
        "${modifier}+Delete" = ''
          exec sh -c "echo -e 'No\nYes' | ${pkgs.wmenu}/bin/wmenu -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4 -l 2 -p 'Exit Sway?' | grep -q Yes && swaymsg exit"
        '';
        
        "${modifier}+p" = "exec swaylock";
        "${modifier}+q" = "kill";
        
        "${modifier}+a" = "exec pkill -x wofi || wofi";

        "XF86AudioMute" = "exec /home/makano/.config/scripts/volumecontrol.sh -o m";
        "XF86AudioMicMute" = "exec /home/makano/.config/scripts/volumecontrol.sh -i m";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        
        "XF86AudioLowerVolume" = "exec /home/makano/.config/scripts/volumecontrol.sh -o d";
        "XF86AudioRaiseVolume" = "exec /home/makano/.config/scripts/volumecontrol.sh -o i";
        
        "XF86MonBrightnessUp" = "exec /home/makano/.config/scripts/brightnesscontrol.sh i";
        "XF86MonBrightnessDown" = "exec /home/makano/.config/scripts/brightnesscontrol.sh d";
        
        "Print" = "exec /home/makano/.config/scripts/screenshot.sh s";
     };
    };
  };
  programs.swaylock = {
    enable = true;
  };
  programs.bash = {
    enable = true;
    initExtra = ''
    '';
    profileExtra = ''
      PATH="$HOME/.local/bin:$PATH"
      export PATH
    '';
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
        require('lspconfig').tsserver.setup{ on_attach = on_attach }
        require('lspconfig').eslint.setup{ on_attach = on_attach }
        require('lspconfig').jdtls.setup{ on_attach = on_attach }
        require('lspconfig').svelte.setup{ on_attach = on_attach }
        require('lspconfig').bashls.setup{ on_attach = on_attach }
        require('lspconfig').pyright.setup{ on_attach = on_attach }
        require('lspconfig').nixd.setup{ on_attach = on_attach }
        require('lspconfig').clangd.setup{ on_attach = on_attach }
        require('lspconfig').html.setup{ on_attach = on_attach }

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
      '';
      extraConfig = ''
        set guicursor=n-v-c-i:block
        set nowrap
        colorscheme catppuccin_mocha
        let g:lightline = {
              \ 'colorscheme': 'catppuccin_mocha',
              \ }
        map <leader>ac :lua vim.lsp.buf.code_action()<CR>
        set ts=2
        set undofile
        set undodir=$HOME/.vim/undodir
        set number
        set autoindent
        set whichwrap+=<,h
        set whichwrap+=>,l
        set whichwrap+=[,]
        nnoremap <c-z> :u<CR>      
        inoremap <c-z> <c-o>:u<CR>
        nnoremap <c-y> :redo<CR>
        inoremap <c-y> <c-o>:redo<CR>                        
        inoremap <C-BS> <C-w>
        nnoremap <C-a> ggVG
        inoremap <C-a> <Esc>ggVG
        inoremap <C-Del> <C-\><C-o>de
        nnoremap <C-b> :NvimTreeToggle<CR>
        nnoremap <C-f> <C-x><C-o>
        nnoremap <C-p> :Files<CR>
        nnoremap <C-q> :q!<CR>
        inoremap <C-q> <Esc>:q!<CR>
        nnoremap <C-s> :w!<CR>
        inoremap <C-s> <Esc>:w!<CR>

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
      ];
    };

  programs.git = {
    enable = true;
    # TODO: set this up
    userEmail = "makanobush@gmail.com";
    userName = "makano";
    # signing = {
    #   key = "";
    #   signByDefault = true;
    # };
    extraConfig = {
    	credential = {
    	  	helper = "store";
    	};	
    };
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      unbind C-b
      set -g prefix M-a
      bind C-a send-prefix
      bind-key C-a last-window
      bind-key a send-prefix
      bind-key b set status
      bind s split-window -v
      bind v split-window -h
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      set -g mouse
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
  programs.waybar = {
    enable = true;
    style = ''
    	* {
    	    border: none;
    	    border-radius: 0px;
    	    font-family: "JetBrainsMono Nerd Font";
    	    font-weight: bold;
    	    font-size: 11px;
    	    min-height: 10px;
    	}
    	
    	@define-color bar-bg rgba(0, 0, 0, 0);
    	
    	@define-color main-bg #11111b;
    	@define-color main-fg #cdd6f4;
    	
    	@define-color wb-act-bg #a6adc8;
    	@define-color wb-act-fg #313244;
    	
    	@define-color wb-hvr-bg #f5c2e7;
    	@define-color wb-hvr-fg #313244;
    	
    	
    	window#waybar {
    	    background: @bar-bg;
    	}
    	
    	tooltip {
    	    background: @main-bg;
    	    color: @main-fg;
    	    border-radius: 7px;
    	    border-width: 0px;
    	}
    	
    	#workspaces button {
    	    box-shadow: none;
    		text-shadow: none;
    	    padding: 0px;
    	    border-radius: 9px;
    	    margin-top: 3px;
    	    margin-bottom: 3px;
    	    padding-left: 3px;
    	    padding-right: 3px;
    	    color: @main-fg;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
    	}
    	
    	#workspaces button.active, #workspaces button.focused {
    	    background: @wb-act-bg;
    	    color: @wb-act-fg;
    	    margin-left: 3px;
    	    padding-left: 12px;
    	    padding-right: 12px;
    	    margin-right: 3px;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    	}

    	#workspaces button.urgent{
    		background: @wb-hvr-bg;
    	}
    	
    	#workspaces button:hover {
    	    background: @wb-hvr-bg;
    	    color: @wb-hvr-fg;
    	    padding-left: 3px;
    	    padding-right: 3px;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    	}
    	
    	#taskbar button {
    	    box-shadow: none;
    		text-shadow: none;
    	    padding: 0px;
    	    border-radius: 9px;
    	    margin-top: 3px;
    	    margin-bottom: 3px;
    	    padding-left: 3px;
    	    padding-right: 3px;
    	    color: @wb-color;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
    	}
    	
    	#taskbar button.active {
    	    background: @wb-act-bg;
    	    color: @wb-act-color;
    	    margin-left: 3px;
    	    padding-left: 12px;
    	    padding-right: 12px;
    	    margin-right: 3px;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    	}
    	
    	#taskbar button:hover {
    	    background: @wb-hvr-bg;
    	    color: @wb-hvr-color;
    	    padding-left: 3px;
    	    padding-right: 3px;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    	}
    	
    	#backlight,
    	#battery,
    	#bluetooth,
    	#custom-cliphist,
    	#clock,
    	#cpu,
    	#custom-gpuinfo,
    	#idle_inhibitor,
    	#language,
    	#memory,
    	#custom-mode,
    	#mpris,
    	#network,
    	#custom-power,
    	#pulseaudio,
    	#custom-spotify,
    	#taskbar,
    	#tray,
    	#custom-updates,
    	#custom-wallchange,
    	#custom-wbar,
    	#window,
    	#workspaces,
    	#custom-l_end,
    	#custom-r_end,
    	#custom-sl_end,
    	#custom-sr_end,
    	#custom-rl_end,
    	#custom-rr_end {
    	    color: @main-fg;
    	    background: @main-bg;
    	    opacity: 1;
    	    margin: 4px 0px 4px 0px;
    	    padding-left: 4px;
    	    padding-right: 4px;
    	}
    	
    	#workspaces,
    	#taskbar {
    	    padding: 0px;
    	}
    	
    	#custom-r_end {
    	    border-radius: 0px 21px 21px 0px;
    	    margin-right: 9px;
    	    padding-right: 3px;
    	}
    	
    	#custom-l_end {
    	    border-radius: 21px 0px 0px 21px;
    	    margin-left: 9px;
    	    padding-left: 3px;
    	}
    	
    	#custom-sr_end {
    	    border-radius: 0px;
    	    margin-right: 9px;
    	    padding-right: 3px;
    	}
    	
    	#custom-sl_end {
    	    border-radius: 0px;
    	    margin-left: 9px;
    	    padding-left: 3px;
    	}
    	
    	#custom-rr_end {
    	    border-radius: 0px 7px 7px 0px;
    	    margin-right: 9px;
    	    padding-right: 3px;
    	}
    	
    	#custom-rl_end {
    	    border-radius: 7px 0px 0px 7px;
    	    margin-left: 9px;
    	    padding-left: 3px;
    	}
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        mod = "dock";
        height = 31;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;

        modules-left = ["custom/padd" "custom/l_end" "cpu" "memory" "custom/gpuinfo" "custom/r_end" "custom/l_end" "idle_inhibitor" "clock" "custom/r_end" "custom/l_end" "sway/workspaces" "custom/r_end" "custom/padd"];
       	modules-center = ["custom/padd" "custom/l_end" "wlr/taskbar" "custom/r_end" "custom/padd"];
       	modules-right = ["custom/padd" "custom/l_end" "backlight" "network" "bluetooth" "pulseaudio" "custom/r_end" "custom/l_end" "tray" "battery" "custom/r_end" "custom/l_end" "custom/wallchange" "custom/cliphist" "custom/power" "custom/r_end" "custom/padd"];

		cpu = {
			interval = 10;
			format = "󰍛 {usage}%";
			format-alt = "{icon0}{icon1}{icon2}{icon3}";
	        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
		};

		memory = {
			interval = 30;
			format = "󰾆 {percentage}%";
			format-alt = "󰾅 {used}GB";
			max-length = 20;
			tooltip = true;
			tooltip-format = " {used:0.1f}GB/{total:0.1f}GB";
		};

		"custom/gpuinfo" = {
			exec = "~/.config/scripts/gpuinfo.sh";
			return-type = "json";
			format = " {}";
			interval = 5;
			tooltip = true;
			max-length = 1000;
		};
		
		idle_inhibitor = {
			format = "{icon}";
			format-icons = {
				activated = "󰥔";
				deactivated = "󰥔";
			};
		};
		
		clock = {
			format = "{:%I:%M %p}";
			format-alt = "{:%R 󰃭 %d·%m·%y}";
			tooltip-format = "<tt>{calendar}</tt>";
			calendar = {
				mode = "month";
				mode-mon-col = 3;
				on-scroll = 1;
				on-click-right = "mode";
				format = {
					months = "<span color='#ffead3'><b>{}</b></span>";
					weekdays = "<span color='#ffcc66'><b>{}</b></span>";
					today = "<span color='#ff6699'><b>{}</b></span>";
				};
			};
			actions = {
				on-click-right = "mode";
				on-click-forward = "tz_up";
				on-click-backward = "tz_down";
				on-scroll-up = "shift_up";
				on-scroll-down = "shift_down";
			};
		};
		
		"sway/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			active-only = true;
			on-click = "activate";
			persistent-workspaces = {};
			format = "{icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "";
				"6" = "";
				"7" = "";
				"8" = "";
				"9" = "󰌳";
				"10" = "";
				default = "";
			};
		};
		
		"wlr/taskbar" = {
			format = "{icon}";
			icon-size = 18;
			icon-theme = "ePapirus-Dark";
			spacing = 0;
			tooltip-format = "{title}";
			on-click = "activate";
			on-click-middle = "close";
			ignore-list = ["Alacritty" "foot" "kitty" "Foot"];
		};
		
		backlight = {
			device = "intel_backlight";
			format = "{icon}  {percent}%";
			format-icons = ["" "" "" "" "" "" "" "" ""];
			on-scroll-up = "brightnessctl set 1%+";
			on-scroll-down = "brightnessctl set 1%-";
			min-length = 6;
		};
		
		network = {
			format-wifi = "󰤨  {essid}";
			format-ethernet = "󱘖 Wired";
			tooltip-format = "󱘖  {ipaddr}   {bandwidthUpBytes}   {bandwidthDownBytes}";
			format-linked = "󱘖  {ifname} (No IP)";
			format-disconnected = " Disconnected";
			format-alt = "󰤨  {signalStrength}%";
			interval = 5;
		};
		
		bluetooth = {
			format = "";
			format-disabled = "";
			format-connected = " {num_connections}";
			tooltip-format = " {device_alias}";
			tooltip-format-connected = "{device_enumerate}";
			tooltip-format-enumerate-connected = " {device_alias}";
		};
		
		pulseaudio = {
			format = "{icon} {volume}";
			format-muted = "󰝟 ";
			on-click = "pavucontrol -t 3";
			on-click-middle = "~/.config/scripts/volumecontrol.sh -o m";
			on-scroll-up = "~/.config/scripts/volumecontrol.sh -o i";
			on-scroll-down = "~/.config/scripts/volumecontrol.sh -o d";
			tooltip-format = "{icon} {desc} // {volume}%";
			scroll-step = 5;
			format-icons = {
	            headphone = "";
	            hands-free = "";
	            headset = "";
	            phone = "";
	            portable = "";
	            car = "";
	            default = ["" " " " "];
	        };
		};
	
		tray = {
			icon-size = 18;
			spacing = 5;
		};
		
		battery = {
			states = {
				good = 95;
				warning = 30;
				critical = 20;
			};
			format = "{icon} {capacity}%";
			format-charging = " {capacity}%";
			format-plugged = " {capacity}%";
			format-alt = "{time} {icon}";
			format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
		};
		
		"custom/wallchange" = {
			format = "󰆊{}";
			exec = "echo ; echo 󰆊 switch wallpaper";
			on-click = "~/.config/scripts/swwwallpaper.sh -n";
			on-click-right = "~/.config/scripts/swwwallpaper.sh -p";
			on-click-middle = "sleep 0.1 && ~/.config/scripts/swwwallselect.sh";
			interval = 86400;
			tooltip = true;
		};

		"custom/cliphist" = {
			format = "{}";
			exec = "echo ; echo 󰅇 clipboard history";
			on-click = "sleep 0.1 && ~/.config/scripts/cliphist.sh c";
			on-click-right = "sleep 0.1 && ~/.config/scripts/cliphist.sh d";
			on-click-middle = "sleep 0.1 && ~/.confi/scripts/cliphist.sh w";
			interval = 86400;
			tooltip = true;
		};
		
		"custom/power" = {
			format = "{}";
			exec = "echo ; echo  logout";
			on-click = "~/.config/scripts/logoutlaunch.sh 2";
			interval = 86400;
			tooltip = true;
		};
		
		"custom/l_end" = {
			format = " ";
			interval = "once";
			tooltip = false;
		};
		
		"custom/r_end" = {
			format = " ";
			interval = "once";
			tooltip = false;
		};
		
		"custom/sl_end" = {
			format = " ";
			interval = "once";
			tooltip = false;
		};
		
		"custom/sr_end" = {
			format = " ";
			interval = "once";
			tooltip = false;
		};
		
		"custom/rl_end" = {
			format = " ";
			interval = "once";
			tooltip = false;
		};
		
		"custom/rr_end" = {
			format = " ";
			interval = "once";
			tooltip = false;
		};
		
		"custom/padd" = {
			format = "  ";
			interval = "once";
			tooltip = false;
		};
		
        
      };
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "Fira Code Nerdfont:size=10";
        dpi-aware = "yes";
        pad = "25x1";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
      	alpha = 0.8;
      };
    };
  };
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      dmenu = true;
      insensitive = true;
      prompt = "";
      width = "50%";
      lines = 15;
      location = "center";
      hide_scroll = true;
      allow_images = true;
    };
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  services.mako = {
    enable = true;
    layer = "overlay";
    font = "Noto Sans";
    defaultTimeout = 5000;
  };
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
    initExtra = ''
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

	#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
		#exec dbus-run-session sway
	#fi
	
    '';
  };

  gtk = {
    enable = true;
    gtk3.bookmarks = [
    	"file:///home/makano/Documents"
    	"file:///home/makano/Downloads"
    	"file:///home/makano/Games"
    	"file:///home/makano/Music"
    	"file:///home/makano/Pictures"
    	"file:///home/makano/Videos"
    	"file:///home/makano/workspace"
    ];
    # iconTheme = {
    	# package = pkgs.gnome.adwaita-icon-theme;
    	# name = "Adwaita";

    	# package = pkgs.dracula-icon-theme;
    	# name = "Dracula";
    # };
    # iconTheme = {
    # 	package = pkgs.papirus-icon-theme;
    # 	name = "Papirus-Dark";
    # };
    # iconTheme = {
    # 	package = pkgs.colloid-icon-theme;
    # 	name = "Colloid-Dark";
    # };
    # iconTheme = {
    # 	package = pkgs.kora-icon-theme;
    # 	name = "kora";
    # };
    # iconTheme = {
    # 	package = pkgs.reversal-icon-theme;
    # 	name = "Reversal";
    # };
    iconTheme = {
    	package = pkgs.epapirus-icon-theme;
    	name = "ePapirus-Dark";
    };
    # iconTheme = {
    # 	package = pkgs.marwaita-icons;
    # 	name = "Marwaita-Dark";
    # };
    cursorTheme = {
    	package = lib.mkForce pkgs.google-cursor;
    	name = lib.mkForce "GoogleDot-Black";
    	size = 12;
    };
    # theme = {
    # 	package = pkgs.tokyonight-gtk-theme;
    # 	name = "Tokyonight-Dark-BL";
    # };
    theme = {
    	package = catppuccin-gtk-theme;
    	name = "Catppuccin-Dark";
    };
    # theme = {
    # 	package = pkgs.dracula-theme;
    # 	name = "Dracula";
    # };
    # theme = {
    # 	package = pkgs.nightfox-gtk-theme;
    # 	name = "Nightfox-Dusk-BL";
    # };
  };

  qt = {
  	enable = true;
  	platformTheme = {
  		# name = "qtct";
  		name = "kvantum";
  	};
  	style.name = "kvantum";
  };

  xdg = {
    enable = true;
  };
  home.preferXdgDirectories = true;
  

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.micro = {
  	enable = true;
  	settings = {
  		autosu = true;
  		colorscheme = "catppuccin-mocha";
  		mkparents = true;
  	};
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code Nerdfont";
      size = 12.0;
    };
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      cursor_shape = "block";
      window_padding_width = 5;
      cursor_blink_interval = 0;
    };
  };

  programs.alacritty = {
  	enable = true;
  	settings = {
  		window = {
  			padding = {
	  			x = 20;
	  			y = 20;
	  		};	
	  		opacity = 0.9;
	  		decorations = "full";
  		};

  		font = {
  			normal = {
  				family = "JetBrains Mono";
  				style = "Regular";
  			};
  			size = 12.0;
  		};

  	};
  };

  programs.senpai = {
  	enable = true;
  	config = {
  		address = "irc.libera.chat:6697";
  		nickname = "makano";
  	};
  };

  xdg.configFile.hyprpaper = {
  	target = "hypr/hyprpaper.conf";
  	text = ''
	 preload = /home/makano/.config/background
	 wallpaper = eDP-1,/home/makano/.config/background
	 splash = false
  	'';
  };
  # , 󰌽, 
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
   	    "[](#a3aed2)"
   	    "[ ](bg:#a3aed2 fg:#090c0c)"
   	    "[](bg:#769ff0 fg:#a3aed2)"
   	    "$directory"
   	    "[](fg:#769ff0 bg:#394260)"
   	    "$git_branch"
   	    "$git_status"
   	    "[](fg:#394260 bg:#212736)"
   	    "$nodejs"
   	    "$rust"
   	    "$golang"
   	    "$php"
   	    "[](fg:#212736 bg:#1d2230)"
   	    "$time"
   	    "[ ](fg:#1d2230)"
   	    "\n$character"
   	  ];
   	  character = {
   	    success_symbol = "[➜](bold fg:#cba6f7)";
   	    error_symbol = "[➜](bold fg:#f38ba8)";
   	  };
   	  directory = {
   	  	style = "fg:#e3e5e5 bg:#769ff0";
   	  	format = "[ $path ]($style)";
   	  	truncation_length = 3;
   	  	truncation_symbol = "…/";
   	  	substitutions = {
   	  		"Documents" = "󰈙 ";
   	  		"Downloads" = " ";
   	  		"Music" = "󰎇";
   	  		"Pictures" = " ";
   	  		"workspace" = "󰆧";
   	  		"data" = "";
   	  		"Archives" = "";
   	  		"Junk" = "";
   	  	};
   	  };
   	  c = {
   	  	symbol = " ";
   	  	style = "bg:color_blue";
   	  	format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
	  };
   	  git_branch = {
   	  	symbol = "";
   	  	style = "bg:#394260";
   	  	format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
   	  };
   	  git_status = {
   	  	style = "bg:#394260";
   	  	format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
   	  };
   	  nodejs = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  rust = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  golang = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  php = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  time = {
   	  	disabled = false;
   	  	time_format = "%R"; # Hour:Minute Format
   	  	style = "bg:#1d2230";
   	  	format = "[[ 󰥔 $time ](fg:#a0a9cb bg:#1d2230)]($style)";
   	  };
    };
  };

  # programs.eza = {
  	# enable = true;
    # enableZshIntegration = true;
 	# enableBashIntegration = true;
	# extraOptions = [
	# 	"--icons"
	# ];
  # };

  programs.gh = {
    enable = true;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  dconf = {
    enable = true;
  	settings."org/gnome/desktop/interface".color-scehem = "prefer-dark";	
  };

  home.pointerCursor = {
  	package = lib.mkForce pkgs.google-cursor;
  	name = lib.mkForce "GoogleDot-Black";
  	size = 12;
  };

  # programs.neovim.nvimdots = {
  #   enable = true;
  #   setBuildEnv = true;
  #   withBuildTools = true;
  # };

  # programs.home-manager.

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
