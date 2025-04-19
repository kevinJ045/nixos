{ config, pkgs, lib, ... }:

{

  home.file.".config/kando/config.json".text = builtins.toJSON {
      menuTheme = "neon-lights";
      darkMenuTheme = "default";
      menuThemeColors = {};
      darkMenuThemeColors = {};
      enableDarkModeForMenuThemes = false;
      sidebarVisible = false;
      enableVersionCheck = true;
      zoomFactor = 1;
  };

    home.file.".config/kando/menus.json".text = builtins.toJSON {
      menus = [
        {
          root = {
            type = "submenu";
            name = "Main Menu";
            icon = "target";
            iconTheme = "material-symbols-rounded";
            children = [
              {
                type = "submenu";
                name = "Apps";
                icon = "apps";
                iconTheme = "material-symbols-rounded";
                children = [
                  {
                    type = "command";
                    data = { command = "chromium"; };
                    name = "Web Browser";
                    icon = "globe";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = { command = "code --ozone-platform-hint=auto"; delayed = true; };
                    name = "Code";
                    icon = "deployed_code";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = { command = "missioncenter"; delayed = true; };
                    name = "Mission Center";
                    icon = "󰘚";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = { command = "nautilus"; };
                    name = "Files";
                    icon = "folder_copy";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = { command = "vlc"; };
                    name = "VLC";
                    icon = "animated_images";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = { command = "foot"; };
                    name = "Terminal";
                    icon = "terminal";
                    iconTheme = "material-symbols-rounded";
                  }
                ];
              }
  
              {
                type = "submenu";
                name = "Web Links";
                icon = "public";
                iconTheme = "material-symbols-rounded";
                children = [
                  {
                    type = "uri";
                    data = { uri = "https://www.google.com"; };
                    name = "Google";
                    icon = "google";
                    iconTheme = "simple-icons";
                  }
                  {
                    type = "uri";
                    data = { uri = "https://github.com"; };
                    name = "Github";
                    icon = "github";
                    iconTheme = "simple-icons";
                  }
                  {
                    type = "uri";
                    data = { uri = "https://www.youtube.com/"; };
                    name = "YouTube";
                    icon = "youtube";
                    iconTheme = "simple-icons";
                  }
                ];
              }
  
              {
                type = "hotkey";
                data = {
                  hotkey = "MetaLeft+Tab";
                  delayed = false;
                };
                name = "Next Workspace";
                icon = "arrow_forward";
                iconTheme = "material-symbols-rounded";
              }
  
              {
                type = "submenu";
                name = "Clipboard";
                icon = "assignment";
                iconTheme = "material-symbols-rounded";
                children = [
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "ControlLeft+KeyV";
                      delayed = true;
                    };
                    name = "Paste";
                    icon = "content_paste_go";
                    iconTheme = "material-symbols-rounded";
                    angle = 90;
                  }
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "ControlLeft+KeyC";
                      delayed = true;
                    };
                    name = "Copy";
                    icon = "content_copy";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "ControlLeft+KeyX";
                      delayed = true;
                    };
                    name = "Cut";
                    icon = "cut";
                    iconTheme = "material-symbols-rounded";
                  }
                ];
              }
  
              {
                type = "submenu";
                name = "Audio";
                icon = "play_circle";
                iconTheme = "material-symbols-rounded";
                children = [
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "MediaTrackNext";
                      delayed = false;
                    };
                    name = "Next Track";
                    icon = "skip_next";
                    iconTheme = "material-symbols-rounded";
                    angle = 90;
                  }
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "MediaPlayPause";
                      delayed = false;
                    };
                    name = "Play / Pause";
                    icon = "play_pause";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "AudioVolumeMute";
                      delayed = false;
                    };
                    name = "Mute";
                    icon = "music_off";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "hotkey";
                    data = {
                      hotkey = "MediaTrackPrevious";
                      delayed = false;
                    };
                    name = "Previous Track";
                    icon = "skip_previous";
                    iconTheme = "material-symbols-rounded";
                    angle = 270;
                  }
                ];
              }
  
              {
                type = "submenu";
                name = "Games";
                icon = "stadia_controller";
                iconTheme = "material-symbols-rounded";
                children = [
                  {
                    type = "command";
                    data = {
                      command = "gamescope -f -- bottles-cli run -p GenshinImpact -b 'Genshin'";
                      delayed = false;
                    };
                    name = "Genshin";
                    icon = "star";
                    iconTheme = "material-symbols-rounded";
                  }
                ];
              }
  
              {
                type = "hotkey";
                data = {
                  hotkey = "MetaLeft+Tab";
                  delayed = false;
                };
                name = "Previous Workspace";
                icon = "arrow_back";
                iconTheme = "material-symbols-rounded";
              }
  
              {
                type = "submenu";
                name = "Bookmarks";
                icon = "folder_special";
                iconTheme = "material-symbols-rounded";
                children = [
                  {
                    type = "command";
                    data = {
                      command = "xdg-open '$(xdg-user-dir DOWNLOAD)'";
                    };
                    name = "Downloads";
                    icon = "download";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = {
                      command = "xdg-open '$(xdg-user-dir VIDEOS)'";
                    };
                    name = "Videos";
                    icon = "video_camera_front";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = {
                      command = "xdg-open '$(xdg-user-dir PICTURES)'";
                    };
                    name = "Pictures";
                    icon = "imagesmode";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = {
                      command = "xdg-open '$(xdg-user-dir DOCUMENTS)'";
                    };
                    name = "Documents";
                    icon = "text_ad";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = {
                      command = "xdg-open '$(xdg-user-dir DESKTOP)'";
                    };
                    name = "Desktop";
                    icon = "desktop_windows";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = {
                      command = "xdg-open ~";
                    };
                    name = "Home";
                    icon = "home";
                    iconTheme = "material-symbols-rounded";
                  }
                  {
                    type = "command";
                    data = {
                      command = "xdg-open '$(xdg-user-dir MUSIC)'";
                    };
                    name = "Music";
                    icon = "music_note";
                    iconTheme = "material-symbols-rounded";
                  }
                ];
              }
            ];
          };
          shortcut = "";
          shortcutID = "main";
          centered = false;
          anchored = false;
        }
      ];
      templates = [];
    };
  
}