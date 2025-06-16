{ config, pkgs, lib, ... }:

{
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
    	
    	@define-color main-bg #1e1e2e;
    	@define-color sec-bg #313244;
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
    	    padding-left: 1px;
    	    padding-right: 1px;
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
    	#custom-swaync,
    	#custom-wbar,
    	#custom-system,
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
    	    border-top: 1px solid @sec-bg;
    	    border-bottom: 1px solid @sec-bg;
    	}
    	
    	#workspaces,
    	#taskbar {
    	    padding: 0px;
    	}
    	
    	#custom-r_end {
    	    border-radius: 0px 21px 21px 0px;
    	    margin-right: 9px;
    	    padding-right: 3px;
       	    border-right: 1px solid @sec-bg;
    	}
    	
    	#custom-l_end {
    	    border-radius: 21px 0px 0px 21px;
    	    margin-left: 9px;
    	    padding-left: 3px;
       	    border-left: 1px solid @sec-bg;
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

        modules-left = ["custom/padd" "custom/l_end" "cpu" "memory" "custom/gpuinfo" "custom/r_end" "custom/l_end" "idle_inhibitor" "clock" "custom/r_end" "custom/l_end" "niri/workspaces" "custom/r_end" "custom/padd"];
       	modules-center = ["custom/padd" "custom/l_end" "wlr/taskbar" "custom/r_end" "custom/padd"];
       	modules-right = ["custom/padd" "custom/l_end" "backlight" "network" "bluetooth" "pulseaudio" "custom/r_end" "custom/l_end" "tray" "battery" "custom/r_end" "custom/l_end" "custom/swaync" "custom/system" "custom/power" "custom/r_end" "custom/padd"];

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
		
		"wlr/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			on-click = "activate";
			persistent-workspaces = {};
			# format = "{icon}";
			format = "{icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "";
				"6" = "";
				"7" = "";
				"8" = "";
				"9" = "󰌳";
				"10" = "";
				default = "";
			};
		};
		
		"niri/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			on-click = "activate";
			persistent-workspaces = {};
			# format = "{icon}";
			format = "{icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				default = " ";
			};
		};
		
		"hyprland/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			on-click = "activate";
			persistent-workspaces = {};
			# format = "{icon}";
			format = "{icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "";
				"6" = "";
				"7" = "";
				"8" = "";
				"9" = "󰌳";
				"10" = "";
				default = "";
			};
		};

		"sway/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			active-only = false;
			on-click = "activate";
			persistent-workspaces = {};
			# format = "{icon}";
			format = "{icon}";
			format-icons = {
				"1" = "";
				"2" = "";
				"3" = "";
				"4" = "";
				"5" = "";
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
			ignore-list = ["Alacritty" "foot" "dev.warp.Warp" "kitty" "Foot"];
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
		
		"custom/swaync" = {
			format = "{}";
			on-click = "swaync-client -t";
			tooltip = false;
		};

		"custom/system" = {
			format = "󰘚{}";
			exec = "echo ; echo 󰘚 system monitor";
			on-click = "sleep 0.1 && missioncenter";
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
}

