{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
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
        {
          key = "ctrl+m";
          command = "editor.action.jumpToBracket";
          when = "editorTextFocus";
        }
        {
          key = "ctrl+w";
          command = "workbench.action.focusPanel";
          when = "editorFocus";
        }
        {
          key = "ctrl+n";
          command = "fileutils.newFile";
          when = "editorFocus";
        }
        {
          key = "ctrl+w";
          command = "workbench.action.focusActiveEditorGroup";
          when = "terminalFocus";
        }
        {
          key = "ctrl+shift+alt+w";
          command = "workbench.action.closeActiveEditor";
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
        "window.menuBarVisibility" = "hidden";
        "window.titleBarStyle" = "custom";
        "workbench.panel.defaultLocation" = "right";
      };
    };
  };
}
