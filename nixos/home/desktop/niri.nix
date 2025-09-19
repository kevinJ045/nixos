{ config, pkgs, lib, ... }:

{


programs.caelestia = {
  enable = true;
  systemd = {
    enable = true; # if you prefer starting from your compositor
    target = "graphical-session.target";
    environment = [];
  };
  settings = {
    bar = {
        entries = [
            {
                "id" = "logo";
                "enabled" = true;
            }
            {
                "id" = "workspaces";
                "enabled" = true;
            }
            {
                "id" = "spacer";
                "enabled" = true;
            }
            {
                "id" = "activeWindow";
                "enabled" = true;
            }
            {
                "id" = "spacer";
                "enabled" = true;
            }
            {
                "id" = "tray";
                "enabled" = true;
            }
            {
                "id" = "clock";
                "enabled" = true;
            }
            {
                "id" = "statusIcons";
                "enabled" = true;
            }
            {
                "id" = "power";
                "enabled" = true;
            }
        ];
        status = {
          showBattery = true;
        };
        workspaces = {
            activeLabel = "";
            label = "";
            occupiedLabel = "";
            # showWindows = false;
        };
    };
    notifs.enable = true;
    genera.apps.terminal = ["foot"];
    services.smartScheme = true;
    services.useFahrenheit = false;
    services.useTwelveHourClock = true;
    paths.wallpaperDir = "~/Pictures";
    launcher = {
        actionPrefix = ">";
    };
  };
  cli = {
    enable = true; # Also add caelestia-cli to path
    settings = {
      theme.enableTerm = false;
      theme.enableQt = false;
      theme.enableGtk = false;
      theme.enableHypr = false;
      theme.enableDiscord = false;
      theme.enableSpicetify = false;
      theme.enableFuzzel = false;
      theme.enableBtop = false;
    };
  };
};

	home.file.".config/niriswitcher/style.css".text = ''
    :root {
      --bg-color: rgb(30, 30, 46);
      --label-color: rgb(205, 214, 244);
      --alternate-label-color: rgb(168, 173, 200);
      --dim-label-color: rgb(88, 91, 112);
      --border-color: rgba(17, 17, 27, 0.95);
      --highlight-color: rgba(203, 166, 247, 0.95);
      --urgency-color: rgb(243, 139, 168);
      --indicator-focus-color: rgba(137, 180, 250, 0.95);
      --indicator-color: rgba(249, 226, 175, 0.95);
    }
'';
	home.file.".config/niriswitcher/config.toml".text = ''
separate_workspaces = false
current_output_only = false
double_click_to_hide = false
center_on_focus = false
log_level = "WARN"

[appearance]
icon_size = 128
max_width = 800
min_width = 600
workspace_format = "{output}-{idx}" # {output}, {idx}, {name}

[workspace]
mru_sort_in_workspace = false
mru_sort_across_workspace = true

[appearance.animation.reveal]
hide_duration = 200
show_duration = 200
easing = "ease-out-cubic"

[appearance.animation.resize]
duration = 200
easing = "ease-in-out-cubic"

[appearance.animation.workspace]
duration = 200
transition = "slide"

[appearance.animation.switch]
duration = 200
easing = "ease-out-cubic"

[keys]
modifier = "Super"

[keys.switch]
next = "Tab"
prev = "Shift+Tab"

[keys.window]
close = "q"
abort = "Escape"

[keys.workspace]
next = "grave"
prev = "Shift+asciitilde"    
'';

	home.file.".config/niri/config.kdl".text = ''

input {
    keyboard {
        xkb {}

        // Enable numlock on startup, omitting this setting disables it.
        numlock
    }
    
    touchpad {
        // off
        tap
        // dwt
        // dwtp
        // drag false
        // drag-lock
        natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "two-finger"
        // disabled-on-external-mouse
    }

    mouse {
        // off
        natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "no-scroll"
    }

    trackpoint {
        // off
        // natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "on-button-down"
        // scroll-button 273
        // middle-emulation
    }

    focus-follows-mouse max-scroll-amount="0%"
}

output "HDMI-A-1" {
    position x=0 y=0
}

output "eDP-1" {
    // off
    position x=1600 y=0
}

clipboard {
    disable-primary
}

layout {
    gaps 16

	center-focused-column "never"
    background-color "transparent"

    preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667

    }
    default-column-width { proportion 0.5; }

    focus-ring {
        off
    }

    border {
        off
    }

}

environment {
    ELECTRON_OZONE_PLATFORM_HINT "auto"
    DISPLAY ":0"
}

// spawn-at-startup "waybar"

spawn-at-startup "xwayland-satellite"
// spawn-at-startup "swaync"
// spawn-at-startup "~/.config/scripts/lowbattery.sh"
// spawn-at-startup "blueman-applet"
// spawn-at-startup "nm-applet" "--indicator"
// spawn-at-startup "hyprpaper"
spawn-at-startup "kdeconnect-indicator"
spawn-at-startup "hypr-autostart"
spawn-at-startup "niriswitcher"

prefer-no-csd

screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

animations {
}

window-rule {
    match app-id=r#"^org\.wezfurlong\.wezterm$"#
    default-column-width {}
}

window-rule {
    match app-id=r#"^zen$"#
    default-column-width {}
}

window-rule {
    match app-id=r#"librewolf"#
    default-column-width {}
}

window-rule {
    match app-id=r#"Waydroid"#
    default-column-width { proportion 0.3; }
}

window-rule {
    match app-id=r#"firefox$"# title="^Picture-in-Picture$"
    open-floating true
}

overview {
    workspace-shadow {
        off
    }
}

window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}

window-rule {
    match is-window-cast-target=true

    focus-ring {
        active-color "#f38ba8"
        inactive-color "#7d0d2d"
    }

    border {
        inactive-color "#7d0d2d"
    }

    shadow {
        color "#7d0d2d70"
    }

    tab-indicator {
        active-color "#f38ba8"
        inactive-color "#7d0d2d"
    }
}

layer-rule {
    match namespace="caelestia"
    place-within-backdrop true
}

gestures {
    hot-corners {
        off
    }
}

hotkey-overlay {
  skip-at-startup;
}

binds {
    Mod+Shift+Slash { show-hotkey-overlay; }

    Mod+T hotkey-overlay-title="Open a Terminal: foot" { spawn "foot"; }
    Mod+A hotkey-overlay-title="Run an Application: wofi" { spawn "caelestia" "shell" "drawers" "toggle" "launcher"; }
    Mod+D hotkey-overlay-title="Run an Application: wmenu" { spawn "${pkgs.wmenu}/bin/wmenu-run" "-i" "-N" "1e1e2e" "-n" "89b4fa" "-M" "1e1e2e" "-m" "89b4fa" "-S" "89b4fa" "-s" "cdd6f4"; }
    Mod+B hotkey-overlay-title="Open Browser" { spawn "app.zen_browser.zen"; }
    Mod+V { spawn "sh" "/home/makano/.config/scripts/cliphist.sh" "c"; }
    Mod+Shift+T hotkey-overlay-title="Open Warp" { spawn "warp-terminal"; }
    Mod+Alt+T hotkey-overlay-title="Open ghostty" { spawn "ghostty"; }
    Super+Alt+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }

    XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
    XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
    XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
    
    XF86MonBrightnessUp     allow-when-locked=true { spawn "brightnessctl" "set" "+5%"; }
    XF86MonBrightnessDown     allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

    Mod+Return repeat=false { toggle-overview; }

    Mod+Q { close-window; }

    Mod+Left  { focus-column-left; }
    Mod+Down  { focus-window-down; }
    Mod+Up    { focus-window-up; }
    Mod+Right { focus-column-right; }
    Mod+H     { focus-column-left; }
    Mod+J     { focus-window-down; }
    Mod+K     { focus-window-up; }
    Mod+L     { focus-column-right; }

    Mod+Ctrl+Left  { move-column-left; }
    Mod+Ctrl+Down  { move-window-down; }
    Mod+Ctrl+Up    { move-window-up; }
    Mod+Ctrl+Right { move-column-right; }
    Mod+Ctrl+H     { move-column-left; }
    Mod+Ctrl+J     { move-window-down; }
    Mod+Ctrl+K     { move-window-up; }
    Mod+Ctrl+L     { move-column-right; }

    Mod+Home { focus-column-first; }
    Mod+End  { focus-column-last; }
    Mod+Ctrl+Home { move-column-to-first; }
    Mod+Ctrl+End  { move-column-to-last; }

    Mod+Shift+Left  { focus-monitor-left; }
    Mod+Shift+Down  { focus-monitor-down; }
    Mod+Shift+Up    { focus-monitor-up; }
    Mod+Shift+Right { focus-monitor-right; }
    Mod+Shift+H     { focus-monitor-left; }
    Mod+Shift+J     { focus-monitor-down; }
    Mod+Shift+K     { focus-monitor-up; }
    Mod+Shift+L     { focus-monitor-right; }

    Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
    Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

    Mod+Page_Down      { focus-workspace-down; }
    Mod+Page_Up        { focus-workspace-up; }
    Mod+U              { focus-workspace-down; }
    Mod+I              { focus-workspace-up; }
    Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
    Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
    Mod+Ctrl+U         { move-column-to-workspace-down; }
    Mod+Ctrl+I         { move-column-to-workspace-up; }
    // ...

    Mod+Shift+Page_Down { move-workspace-down; }
    Mod+Shift+Page_Up   { move-workspace-up; }
    Mod+Shift+U         { move-workspace-down; }
    Mod+Shift+I         { move-workspace-up; }


    Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    Mod+WheelScrollRight      { focus-column-right; }
    Mod+WheelScrollLeft       { focus-column-left; }
    Mod+Ctrl+WheelScrollRight { move-column-right; }
    Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    Mod+Shift+WheelScrollDown      { focus-column-right; }
    Mod+Shift+WheelScrollUp        { focus-column-left; }
    Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+Ctrl+1 { move-column-to-workspace 1; }
    Mod+Ctrl+2 { move-column-to-workspace 2; }
    Mod+Ctrl+3 { move-column-to-workspace 3; }
    Mod+Ctrl+4 { move-column-to-workspace 4; }
    Mod+Ctrl+5 { move-column-to-workspace 5; }
    Mod+Ctrl+6 { move-column-to-workspace 6; }
    Mod+Ctrl+7 { move-column-to-workspace 7; }
    Mod+Ctrl+8 { move-column-to-workspace 8; }
    Mod+Ctrl+9 { move-column-to-workspace 9; }

    //Mod+Tab { focus-window-previous; }
    Mod+Tab repeat=false { spawn "niriswitcherctl" "show" "--window"; }

    Mod+BracketLeft  { consume-or-expel-window-left; }
    Mod+BracketRight { consume-or-expel-window-right; }

    Mod+Comma  { consume-window-into-column; }

    Mod+Period { expel-window-from-column; }

    Mod+R { switch-preset-column-width; }
    Mod+Shift+R { switch-preset-window-height; }
    Mod+Ctrl+R { reset-window-height; }
    Mod+W { maximize-column; }
    Mod+F { fullscreen-window; }

    Mod+Ctrl+F { expand-column-to-available-width; }

    Mod+C { center-column; }

    Mod+Ctrl+C { center-visible-columns; }

    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }

    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    Mod+Space       { toggle-window-floating; }
    Mod+Shift+Space { switch-focus-between-floating-and-tiling; }

    Mod+S { toggle-column-tabbed-display; }

    // Mod+Space       { switch-layout "next"; }
    // Mod+Shift+Space { switch-layout "prev"; }

    Print { screenshot; }
    Ctrl+Print { screenshot-screen; }
    Alt+Print { screenshot-window; }

    Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

    Mod+Shift+E { quit; }
    Mod+Delete { quit; }
    Ctrl+Alt+Delete { quit; }

    Mod+Shift+P { power-off-monitors; }
}

	'';

}
