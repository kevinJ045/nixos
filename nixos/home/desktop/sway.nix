{ config, pkgs, lib, ... }:

{
    wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    extraConfig = ''
	bindgesture swipe:right workspace prev
	bindgesture swipe:left workspace next
	bindgesture swipe:up focus left
	bindgesture swipe:down focus right
	corner_radius 10

	# Catppuccin Mocha - Client Styles
	client.focused          #1e1e2e #89b4fa #cdd6f4 #b4befe #89b4fa
	client.focused_inactive #1e1e2e #313244 #a6adc8 #6c7086 #313244
	client.unfocused        #1e1e2e #313244 #a6adc8 #313244 #313244
	client.urgent           #1e1e2e #f38ba8 #11111b #f38ba8 #f38ba8
	
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
      	{ command = "wl-paste --type text --watch cliphist store"; }
      	{ command = "wl-paste --type image --watch cliphist store"; }
      	{ command = "swaync"; }
      	{ command = "kdeconnect-indicator"; }
      	{ command = "hypr-autostart"; }
      ];
      modifier = "Mod4";
      terminal = "warp-terminal";
      menu = "pkill -x wmenu-run || ${pkgs.wmenu}/bin/wmenu-run -i -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4";
      # fonts = {
      #   names = [ "JetBrains Mono" "FontAwesome" ];
      #   style = "Bold Semi-Condensed";
      #   size = 11.0;
      # };
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
        "${modifier}+b" = "exec zen";
        "${modifier}+c" = "exec code";
        "${modifier}+t" = "exec foot";
        
        "${modifier}+l" = "exec swaylock";
        
        "${modifier}+Tab" = "workspace back_and_forth";
        "${modifier}+Shift+p" = ''
          exec swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | {app_id, pid, name, id, shell, window}' | jq -r 'to_entries[] | "\(.key | ascii_upcase)\t\n\(.value)"' | zenity --list --title="Window Properties" --column="Field" --column="Value" --width=400 --height=300
        '';
        
        "${modifier}+Shift+b" = "exec pkill -SIGUSR1 waybar";
        
        "${modifier}+w" = "floating toggle";
        "${modifier}+s" = "layout tabbed";
        "${modifier}+Shift+space" = "layout stacking";
        
        "${modifier}+Delete" = ''
          exec sh -c "echo -e 'No\nYes' | ${pkgs.wmenu}/bin/wmenu -N 1e1e2e -n 89b4fa -M 1e1e2e -m 89b4fa -S 89b4fa -s cdd6f4 -l 2 -p 'Exit Sway?' | grep -q Yes && swaymsg exit"
        '';
        
        "${modifier}+p" = "exec swaylock";
        "${modifier}+q" = "kill";
        "${modifier}+v" = "exec /home/makano/.config/scripts/cliphist.sh c";
        
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
  
}
