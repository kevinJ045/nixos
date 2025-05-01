{ config, pkgs, lib, ... }:


{

  wayland.windowManager.hyprland = {
  	enable = true;
  	settings = {
  		"$asrcPath" = "~/.config/scripts";
  		"$mainMod" = "SUPER";
  		"$term" = "foot";
  		"$editor" = "code --disable-gpu --ozone-platform-hint=auto";
  		"$file" = "nautilus";
  		"$browser" = "xdg-open https://google.com";
  		"exec-once" = [
  			"$asrcPath/lowbattery.sh"
  			"waybar"
  			"blueman-applet"
  			"nm-applet --indicator"
  			"mako"
  			"wl-paste --type text --watch cliphist store"
  			"wl-paste --type image --watch cliphist store"
  			"hyprpaper"
  			"kando"
  			"swaync"
  			"kdeconnect-indicator"
  			"hypr-autostart"
  		];
  		# monitor = "VIRTUAL-1,1920x1080@60,1920x0,1";
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
  			"$mainMod, space, exec, kando -m main "
  			
  			''$mainMod SHIFT, P, exec, foot -e sh -c "hyprctl activewindow && read"''
  			
  			"$mainMod, T, exec, $term  "
  			"$mainMod, Z, exec, $file "
  			"$mainMod, C, exec, $editor "
  			"$mainMod, B, exec, $browser "
  			"$CONTROL SHIFT, ESCAPE, exec, $asrcPath/sysmonlaunch.sh  "
  			
  			"$mainMod SHIFT, B, exec, pkill waybar -SIGUSR1"
  			
  			"$mainMod, A, exec, pkill -x wofi || wofi"
  			"$mainMod, D, exec, pkill -x wmenu-run || ${pkgs.wmenu}/bin/wmenu-run -i -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4"
  			"$mainMod, tab, workspace, previous"
  			
  			"$mainMod, P, exec, $asrcPath/screenshot.sh p "
  			"$mainMod CTRL, P, exec, $asrcPath/screenshot.sh sf "
  			"$mainMod ALT, P, exec, sh $asrcPath/screenshot.sh m "
  			" , print, exec, $asrcPath/screenshot.sh s  "
  			# '' ,print, exec, kitty -e sh -c "cat $srcPath/screenshot.sh && read -p '$srcPath/screenshot.sh' -r"''
  			
  			
  			"$mainMod ALT, G, exec, $asrcPath/gamemode.sh "
  			# "$mainMod, R, exec, pkill -x wmenu-run || ${pkgs.wmenu}/bin/wmenu-run -i -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4"
  			"$mainMod, V, exec, $asrcPath/cliphist.sh c"
  			
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
					# no_vsync = true;
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
  
  
}
