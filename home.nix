{ config, pkgs, lib, ... }:

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
  	extraConfig = ''
$scrPath = ~/.config/scripts
exec-once = $scrPath/resetxdgportal.sh # reset XDPH for screenshare
exec-once = $scrPath/lowbattery.sh # reset XDPH for screenshare
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH
exec-once = dbus-update-activation-environment --systemd --all # for XDPH
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH
exec-once = /usr/lib/polkit-kde-authentication-agent-1 # authentication dialogue for GUI apps
exec-once = waybar # launch the system panel
exec-once = blueman-applet # systray app for BT
exec-once = nm-applet --indicator # systray app for Network/Wifi
exec-once = dunst # start notification demon
exec-once = wl-paste --type text --watch cliphist store # clipboard store text data
exec-once = wl-paste --type image --watch cliphist store # clipboard store image data
exec-once = hyprpaper
exec-once = $scrPath/batterynotify.sh # battery notification


# Main modifier
$mainMod = SUPER # windows key

# █▀▀ █▄░█ █░█
# ██▄ █░▀█ ▀▄▀

# Some default env vars.

env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
# env = QT_QPA_PLATFORM,wayland
# env = QT_STYLE_OVERRIDE,kvantum
# env = QT_QPA_PLATFORMTHEME,qt6ct
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = MOZ_ENABLE_WAYLAND,1
env = XCURSOR_THEME,GoogleDot-Black

env = XDG_DESKTOP_DIR,$HOME/Desktop
env = XDG_DOWNLOAD_DIR,$HOME/Downloads
env = XDG_TEMPLATES_DIR,$HOME/Templates
env = XDG_PUBLICSHARE_DIR,$HOME/Public
env = XDG_DOCUMENTS_DIR,$HOME/Documents
env = XDG_MUSIC_DIR,$HOME/Music
env = XDG_PICTURES_DIR,$HOME/Pictures
env = XDG_VIDEOS_DIR,$HOME/Videos




# █ █▄░█ █▀█ █░█ ▀█▀
# █ █░▀█ █▀▀ █▄█ ░█░

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/

input {
    kb_layout = us
    follow_mouse = 1
    natural_scroll = yes

    touchpad {
        natural_scroll = yes
        disable_while_typing = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    force_no_accel = 1
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more

# device:epic mouse V1 {
#     sensitivity = -0.5
# }

# See https://wiki.hyprland.org/Configuring/Variables/ for more

gestures {
    workspace_swipe = true
    workspace_swipe_fingers = 3
}



# █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
# █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more

dwindle {
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more

master {
    new_is_master = true
}



# █▀▄▀█ █ █▀ █▀▀
# █░▀░█ █ ▄█ █▄▄

# See https://wiki.hyprland.org/Configuring/Variables/ for more

misc {
    vrr = 0
    disable_hyprland_logo = true
    disable_splash_rendering = true
}

animations {
    enabled = yes
    bezier = wind, 0.05, 0.9, 0.1, 1.05
    bezier = winIn, 0.1, 1.1, 0.1, 1.1
    bezier = winOut, 0.3, -0.3, 0, 1
    bezier = liner, 1, 1, 1, 1
    animation = windows, 1, 6, wind, slide
    animation = windowsIn, 1, 6, winIn, slide
    animation = windowsOut, 1, 5, winOut, slide
    animation = windowsMove, 1, 5, wind, slide
    animation = borderangle, 1, 30, liner, loop
    animation = fade, 1, 10, default
    animation = workspaces, 1, 5, wind
}


# █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
# █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█


# See https://wiki.hyprland.org/Configuring/Keywords/ for more
# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

# assign apps
# $term = alacritty
# $term = foot
$term = kitty
$editor = code --disable-gpu
$file = nautilus
$browser = chromium


# Window/Session actions
bind = $mainMod, Q, exec, $scrPath/dontkillsteam.sh # killactive, kill the window on focus
bind = $mainMod, delete, exit, # kill hyperland session
bind = $mainMod, W, togglefloating, # toggle the window on focus to float
bind = $mainMod, G, togglegroup, # toggle the window on focus to float
bind = $mainMod, F, fullscreen, # toggle the window on focus to fullscreen
bind = $mainMod, L, exec, swaylock # lock screen
bind = $mainMod, backspace, exec, $scrPath/logoutlaunch.sh 1 # logout menu

# Application shortcuts
bind = $mainMod, T, exec, $term  # open terminal
bind = $mainMod, Z, exec, $file # open file manager
bind = $mainMod, C, exec, $editor # open vscode
bind = $mainMod, B, exec, $browser # open browser
bind = $CONTROL SHIFT, ESCAPE, exec, $scrPath/sysmonlaunch.sh  # open htop/btop if installed or default to top (system monitor)

# Rofi is toggled on/off if you repeat the key presses
bind = $mainMod, D, exec, pkill -x wofi || wofi
bind = $mainMod, tab, workspace, previous

# Audio control
# bindl  = , F10, exec, $scrPath/volumecontrol.sh -o m # toggle audio mute
# bindel = , F11, exec, $scrPath/volumecontrol.sh -o d # decrease volume
# bindel = , F12, exec, $scrPath/volumecontrol.sh -o i # increase volume
bindl  = , XF86AudioMute, exec, $scrPath/volumecontrol.sh -o m # toggle audio mute
bindl  = , XF86AudioMicMute, exec, $scrPath/volumecontrol.sh -i m # toggle microphone mute
bindel = , XF86AudioLowerVolume, exec, $scrPath/volumecontrol.sh -o d # decrease volume
bindel = , XF86AudioRaiseVolume, exec, $scrPath/volumecontrol.sh -o i # increase volume
bindl  = , XF86AudioPlay, exec, playerctl play-pause
bindl  = , XF86AudioPause, exec, playerctl play-pause
bindl  = , XF86AudioNext, exec, playerctl next
bindl  = , XF86AudioPrev, exec, playerctl previous

# Brightness control
bindel = , XF86MonBrightnessUp, exec, $scrPath/brightnesscontrol.sh i # increase brightness
bindel = , XF86MonBrightnessDown, exec, $scrPath/brightnesscontrol.sh d # decrease brightness

# Screenshot/Screencapture
bind = $mainMod, P, exec, $scrPath/screenshot.sh p # drag to snip an area / click on a window to print it
bind = $mainMod CTRL, P, exec, $scrPath/screenshot.sh sf # frozen screen, drag to snip an area / click on a window to print it
bind = $mainMod ALT, P, exec, $scrPath/screenshot.sh m # print focused monitor
bind = ,print, exec, $scrPath/screenshot.sh s  # print all monitor outputs

# Exec custom scripts
bind = $mainMod ALT, G, exec, $scrPath/gamemode.sh # disable hypr effects for gamemode
bind = $mainMod ALT, right, exec, $scrPath/swwwallpaper.sh -n # next wallpaper
bind = $mainMod ALT, left, exec, $scrPath/swwwallpaper.sh -p # previous wallpaper
bind = $mainMod ALT, up, exec, $scrPath/wbarconfgen.sh n # next waybar mode
bind = $mainMod ALT, down, exec, $scrPath/wbarconfgen.sh p # previous waybar mode
bind = $mainMod SHIFT, D, exec, $scrPath/wallbashtoggle.sh  # toggle wallbash on/off
bind = $mainMod, R, exec, pkill -x wmenu-run || ${pkgs.wmenu}/bin/wmenu-run -i -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4
bind = $mainMod SHIFT, T, exec, pkill -x rofi || $scrPath/themeselect.sh # theme select menu
bind = $mainMod SHIFT, A, exec, pkill -x rofi || $scrPath/rofiselect.sh # rofi style select menu
bind = $mainMod SHIFT, W, exec, pkill -x rofi || $scrPath/swwwallselect.sh # rofi wall select menu
bind = $mainMod, V, exec, pkill -x rofi || $scrPath/cliphist.sh c  # open Pasteboard in screen center
bind = $mainMod, K, exec, $scrPath/keyboardswitch.sh # change keyboard layout

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d
bind = ALT, Tab, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
bind = $mainMod CTRL, right, workspace, r+1 
bind = $mainMod CTRL, left, workspace, r-1

# move to the first empty workspace instantly with mainMod + CTRL + [↓]
bind = $mainMod CTRL, down, workspace, empty 

# Resize windows
binde = $mainMod SHIFT, right, resizeactive, 30 0
binde = $mainMod SHIFT, left, resizeactive, -30 0
binde = $mainMod SHIFT, up, resizeactive, 0 -30
binde = $mainMod SHIFT, down, resizeactive, 0 30

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
bind = $mainMod CTRL ALT, right, movetoworkspace, r+1
bind = $mainMod CTRL ALT, left, movetoworkspace, r-1

# Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
bind = $mainMod SHIFT $CONTROL, left, movewindow, l
bind = $mainMod SHIFT $CONTROL, right, movewindow, r
bind = $mainMod SHIFT $CONTROL, up, movewindow, u
bind = $mainMod SHIFT $CONTROL, down, movewindow, d

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/Resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Special workspaces (scratchpad)
bind = $mainMod ALT, S, movetoworkspacesilent, special
bind = $mainMod, S, togglespecialworkspace,

# Toggle Layout
bind = $mainMod, J, togglesplit, # dwindle

# Move window silently to workspace Super + Alt + [0-9]
bind = $mainMod ALT, 1, movetoworkspacesilent, 1
bind = $mainMod ALT, 2, movetoworkspacesilent, 2
bind = $mainMod ALT, 3, movetoworkspacesilent, 3
bind = $mainMod ALT, 4, movetoworkspacesilent, 4
bind = $mainMod ALT, 5, movetoworkspacesilent, 5
bind = $mainMod ALT, 6, movetoworkspacesilent, 6
bind = $mainMod ALT, 7, movetoworkspacesilent, 7
bind = $mainMod ALT, 8, movetoworkspacesilent, 8
bind = $mainMod ALT, 9, movetoworkspacesilent, 9
bind = $mainMod ALT, 0, movetoworkspacesilent, 10

# Trigger when the switch is turning off
bindl= , switch:on:Lid Switch, exec, swaylock && systemctl suspend


# █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
# ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█


# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

# windowrulev2 = opacity 0.90 0.90,class:^(firefox)$
windowrulev2 = opacity 0.90 0.90,class:^(Brave-browser)$
windowrulev2 = opacity 0.80 0.80,class:^(Steam)$
windowrulev2 = opacity 0.80 0.80,class:^(steam)$
windowrulev2 = opacity 0.80 0.80,class:^(steamwebhelper)$
windowrulev2 = opacity 0.80 0.80,class:^(Spotify)$
windowrulev2 = opacity 0.80 0.80,class:^(code-url-handler)$
windowrulev2 = opacity 0.80 0.80,class:^(kitty)$
windowrulev2 = opacity 0.80 0.80,class:^(org.kde.dolphin)$
windowrulev2 = opacity 0.80 0.80,class:^(org.kde.ark)$
windowrulev2 = opacity 0.80 0.80,class:^(nwg-look)$
windowrulev2 = opacity 0.80 0.80,class:^(qt5ct)$

windowrulev2 = opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$ #Flatseal-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$ #Cartridges-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(com.obsproject.Studio)$ #Obs-Qt
windowrulev2 = opacity 0.80 0.80,class:^(gnome-boxes)$ #Boxes-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(discord)$ #Discord-Electron
windowrulev2 = opacity 0.80 0.80,class:^(WebCord)$ #WebCord-Electron
windowrulev2 = opacity 0.80 0.80,class:^(app.drey.Warp)$ #Warp-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
windowrulev2 = opacity 0.80 0.80,class:^(yad)$ #Protontricks-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(Signal)$ #Signal-Gtk
windowrulev2 = opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk

windowrulev2 = opacity 0.80 0.70,class:^(pavucontrol)$
windowrulev2 = opacity 0.80 0.70,class:^(blueman-manager)$
windowrulev2 = opacity 0.80 0.70,class:^(nm-applet)$
windowrulev2 = opacity 0.80 0.70,class:^(nm-connection-editor)$
windowrulev2 = opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$

windowrulev2 = float,class:^(qt5ct)$
windowrulev2 = float,class:^(nwg-look)$
windowrulev2 = float,class:^(org.kde.ark)$
windowrulev2 = float,class:^(Signal)$ #Signal-Gtk
windowrulev2 = float,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk
windowrulev2 = float,class:^(app.drey.Warp)$ #Warp-Gtk
windowrulev2 = float,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
windowrulev2 = float,class:^(yad)$ #Protontricks-Gtk
windowrulev2 = float,class:^(eog)$ #Imageviewer-Gtk
windowrulev2 = float,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk
windowrulev2 = float,class:^(pavucontrol)$
windowrulev2 = float,class:^(blueman-manager)$
windowrulev2 = float,class:^(nm-applet)$
windowrulev2 = float,class:^(nm-connection-editor)$
windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$



#█▀▀ █░█ █▀█ █▀ █▀█ █▀█
#█▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄

#env = XCURSOR_THEME,Bibata-Modern-Ice
#env = XCURSOR_SIZE,12

exec = hyprctl setcursor GoogleDot-Black 12
# exec = gsettings set org.gnome.desktop.interface cursor-theme 'GoogleDot-Black'
# exec = gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-dark'


#█▀▀ █▀█ █▄░█ ▀█▀
#█▀░ █▄█ █░▀█ ░█░

exec = gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Bold'
exec = gsettings set org.gnome.desktop.interface document-font-name 'JetBrains Mono Bold'
exec = gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Bold'
exec = gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
exec = gsettings set org.gnome.desktop.interface font-hinting 'full'


#█▀ █▀█ █▀▀ █▀▀ █ ▄▀█ █░░
#▄█ █▀▀ ██▄ █▄▄ █ █▀█ █▄▄

decoration {
    dim_special = 0.3
    blur {
        special = true
    }
    rounding = 10
}

general {
    border_size = 0
}


#█░█ █▀ █▀▀ █▀█   █▀█ █▀█ █▀▀ █▀▀ █▀
#█▄█ ▄█ ██▄ █▀▄   █▀▀ █▀▄ ██▄ █▀░ ▄█


# Set your personal hyprland configuration here
# for sample file, please refer https://github.com/prasanthrangan/hyprdots/blob/main/Configs/.config/hypr/userprefs.t2

bind = $mainMod, D, exec, dmenu_run -nb "#1e1e2e" -nf "#cdd6f4" -sb "#89dceb" -sf "#1e1e2e"

animations {
    # enabled = no
	# first_launch_animation = no
}

decoration {
	blur {
		enabled = no
		size = 2
		passes = 2
	}
}

binds {
	workspace_back_and_forth = yes
	allow_workspace_cycles = yes
}

# devic:yspringtech-usb-optical-mouse {
	# natural_scroll = yes
# }




  	'';
  };
  
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
	exec "/home/makano/.config/scripts/swaystart.sh"
    '';
    config = rec {
      modifier = "Mod4";
      terminal = "foot"; 
      menu = "wofi";
      fonts = {
        names = [ "Noto Sans" "FontAwesome" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };
      output = {
        "*" = {
          bg = "${builtins.fetchurl { url = "https://images.hdqwalls.com/download/1/beach-seaside-digital-painting-4k-05.jpg"; sha256 = "2877925e7dab66e7723ef79c3bf436ef9f0f2c8968923bb0fff990229144a3fe"; }} fill";
        };
        "Dell Inc. Dell AW3821DW #GTIYMxgwABhF" = {
          mode = "3840x1600@143.998Hz";
          adaptive_sync = "on";
          max_render_time = "1";
          subpixel = "none";
        };
      };
      bars = [{
        command = "sh -c 'pgrep -x waybar > /dev/null || waybar &'";
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
        inner = 15;
        smartGaps = true;
      };
      focus.followMouse = true;
      workspaceAutoBackAndForth = true;
      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier; in lib.mkOptionDefault {
        "${modifier}+t" = "exec alacritty";
        "${modifier}+p" = "exec swaylock";
        "${modifier}+q" = "kill";
        "${modifier}+shift+u" = "exec playerctl play-pause";
        "${modifier}+shift+y" = "exec playerctl previous";
        "${modifier}+shift+i" = "exec playerctl next";
        "Control+space" = "exec makoctl dismiss";
        "${modifier}+Control+space" = "exec makoctl restore";
        "${modifier}+shift+x" = "exec ~/.local/bin/screenshot";
        "${modifier}+x" = "exec ~/.local/bin/screenshot-select";
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
        nnoremap <c-z> :u<CR>      
        inoremap <c-z> <c-o>:u<CR>
        nnoremap <c-y> :redo<CR>
        inoremap <c-y> <c-o>:redo<CR>                        
        inoremap <C-BS> <C-\><C-o>db
        inoremap <C-Del> <C-\><C-o>de
        nnoremap <C-b> :NvimTreeToggle<CR>
        nnoremap <C-f> <C-x><C-o>
        nnoremap <C-p> :Files<CR>
        nnoremap <C-q> :q!
        nnoremap <C-c> y
        nnoremap <C-v> p
        vnoremap <C-c> y
        vnoremap <C-v> p
        inoremap <C-v> <C-r>

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
      set -g prefix A-a
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
    	
    	#workspaces button.active {
    	    background: @wb-act-bg;
    	    color: @wb-act-fg;
    	    margin-left: 3px;
    	    padding-left: 12px;
    	    padding-right: 12px;
    	    margin-right: 3px;
    	    animation: gradient_f 20s ease-in infinite;
    	    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
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

        modules-left = ["custom/padd" "custom/l_end" "cpu" "memory" "custom/gpuinfo" "custom/r_end" "custom/l_end" "idle_inhibitor" "clock" "custom/r_end" "custom/l_end" "hyprland/workspaces" "custom/r_end" "custom/padd"];
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
		
		"hyprland/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			on-click = "activate";
			persistent-workspaces = {};
		};
		
		"wlr/taskbar" = {
			format = "{icon}";
			icon-size = 18;
			icon-theme = "Dracula";
			spacing = 0;
			tooltip-format = "{title}";
			on-click = "activate";
			on-click-middle = "close";
			ignore-list = ["Alacritty" "foot" "kitty" "Foot"];
		};
		
		backlight = {
			device = "intel_backlight";
			format = "{icon} {percent}%";
			format-icons = ["" "" "" "" "" "" "" "" ""];
			on-scroll-up = "brightnessctl set 1%+";
			on-scroll-down = "brightnessctl set 1%-";
			min-length = 6;
		};
		
		network = {
			format-wifi = "󰤨 {essid}";
			format-ethernet = "󱘖 Wired";
			tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
			format-linked = "󱘖 {ifname} (No IP)";
			format-disconnected = " Disconnected";
			format-alt = "󰤨 {signalStrength}%";
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
			format-muted = "婢";
			on-click = "pavucontrol -t 3";
			on-click-middle = "~/.config/hypr/scripts/volumecontrol.sh -o m";
			on-scroll-up = "~/.config/hypr/scripts/volumecontrol.sh -o i";
			on-scroll-down = "~/.config/hypr/scripts/volumecontrol.sh -o d";
			tooltip-format = "{icon} {desc} // {volume}%";
			scroll-step = 5;
			format-icons = {
	            headphone = "";
	            hands-free = "";
	            headset = "";
	            phone = "";
	            portable = "";
	            car = "";
	            default = ["" "" ""];
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
			on-click = "~/.config/hypr/scripts/swwwallpaper.sh -n";
			on-click-right = "~/.config/hypr/scripts/swwwallpaper.sh -p";
			on-click-middle = "sleep 0.1 && ~/.config/hypr/scripts/swwwallselect.sh";
			interval = 86400;
			tooltip = true;
		};

		"custom/cliphist" = {
			format = "{}";
			exec = "echo ; echo 󰅇 clipboard history";
			on-click = "sleep 0.1 && ~/.config/hypr/scripts/cliphist.sh c";
			on-click-right = "sleep 0.1 && ~/.config/hypr/scripts/cliphist.sh d";
			on-click-middle = "sleep 0.1 && ~/.config/hypr/scripts/cliphist.sh w";
			interval = 86400;
			tooltip = true;
		};
		
		"custom/power" = {
			format = "{}";
			exec = "echo ; echo  logout";
			on-click = "~/.config/hypr/scripts/logoutlaunch.sh 2";
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
	export PATH="$PATH:$HOME/portables/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.local/share/scripts/bin"
	export MICRO_TRUECOLOR=1

	alias game64="WINEPREFIX=/home/makano/Games/wine64 wine64"
	alias game32="WINEPREFIX=/home/makano/Games/wine32 wine"

	bindkey '^H' backward-kill-word
    '';
  };

  gtk = {
    enable = true;
    iconTheme = {
    	# package = pkgs.gnome.adwaita-icon-theme;
    	# name = "Adwaita";

    	# package = pkgs.dracula-icon-theme;
    	# name = "Dracula";
    };
    cursorTheme = {
    	package = lib.mkForce pkgs.google-cursor;
    	name = lib.mkForce "GoogleDot-Black";
    	size = 12;
    };
  };

  qt = {
  	enable = true;
  	platformTheme = {
  		name = "qtct";
  	};
  	style.name = "kvantum";
  };

  xdg = {
    enable = true;
  };

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
   	    "[ ](bg:#a3aed2 fg:#090c0c)"
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

  programs.eza = {
  	enable = true;
  	enableZshIntegration = true;
  	enableBashIntegration = true;
	extraOptions = [
		"--icons"
	];
  };

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

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
