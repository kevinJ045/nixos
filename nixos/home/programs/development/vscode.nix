{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.makano = {
      keybindings = [
        {
          key = "ctrl+d";
          command = "editor.action.duplicateSelection";
          when = "textInputFocus";
        },
      ];
      userSettings = {
        "editor.tabSize" = 2;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "explorer.confirmDelete" = false;
        "explorer.confirmPasteNative" = false;
        "explorer.confirmDragAndDrop" = false;
      };
    };
  };
}