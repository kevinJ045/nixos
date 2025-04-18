{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    # profiles.makano = {
      keybindings = [
        {
          key = "ctrl+d";
          command = "editor.action.duplicateSelection";
          when = "textInputFocus";
        }
        {
          key = "ctrl+shift+d";
          command = "editor.action.addSelectionToNextFindMatch";
          when = "editorFocus";
        }
      ];
      userSettings = {
        "editor.tabSize" = 2;
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmPasteNative" = false;
        "explorer.confirmDragAndDrop" = false;
      };
    # };
  };
}