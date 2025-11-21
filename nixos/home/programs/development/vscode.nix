{ config, pkgs, lib, ... }:

{
  # programs.lapce = {
  #   enable = true;
  # };
  # programs.zed-editor = {
    # enable = true;
    # mutableUserSettings = true;
    # mutableUserKeymaps = true;

    # userSettings = {
    #   ui_font_size = 13;
    #   buffer_font_size = 13;

    #   theme = {
    #     mode = "system";
    #     light = "One Light";
    #     dark = "Catppuccin Mocha";
    #   };

    #   buffer_font_family = "Fira Code";
    # };

    # userKeymaps = [
    #   {
    #     context = "Editor";
    #     bindings = {
    #       ctrl-d = "editor::DuplicateLineDown";
    #       ctrl-shift-d = [
    #         "editor::SelectNext"
    #         { replace_newest = false; }
    #       ];
    #       "ctrl-`" = "workspace::ActivatePaneRight";
    #     };
    #   }
    #   {
    #     context = "Terminal";
    #     bindings = {
    #       "ctrl-`" = "workspace::ActivatePaneLeft";
    #     };
    #   }
    # ];
  # };
  programs.vscode = {
    enable = true;
    # profiles.default = {
      # extensions = with pkgs; [
      # 	vscode-extensions.catppuccin.catppuccin-vsc
      # 	vscode-extensions.catppuccin.catppuccin-vsc-icons
      # 	vscode-extensions.vadimcn.vscode-lldb
      # 	vscode-extensions.esbenp.prettier-vscode
      # 	vscode-extensions.prisma.prisma
      # 	vscode-extensions.rust-lang.rust-analyzer
      # 	vscode-extensions.bbenoist.nix
      # 	vscode-extensions.brettm12345.nixfmt-vscode
      # ];
      # keybindings = [
      #   {
      #     key = "ctrl+d";
      #     command = "editor.action.duplicateSelection";
      #     when = "textInputFocus";
      #   }
      #   {
      #     key = "ctrl+shift+d";
      #     command = "editor.action.addSelectionToNextFindMatch";
      #     when = "editorFocus";
      #   }
      #   {
      #     key = "ctrl+m";
      #     command = "editor.action.jumpToBracket";
      #     when = "editorTextFocus";
      #   }
      #   {
      #     key = "ctrl+w";
      #     command = "workbench.action.focusPanel";
      #     when = "editorFocus";
      #   }
      #   {
      #     key = "ctrl+n";
      #     command = "fileutils.newFile";
      #     when = "editorFocus";
      #   }
      #   {
      #     key = "ctrl+w";
      #     command = "workbench.action.focusActiveEditorGroup";
      #     when = "terminalFocus";
      #   }
      #   {
      #     key = "ctrl+`";
      #     command = "workbench.action.focusActiveEditorGroup";
      #     when = "terminalFocus";
      #   }
    #     {
    #       key = "ctrl+shift+alt+w";
    #       command = "workbench.action.closeActiveEditor";
    #       when = "editorFocus";
    #     }
    #   ];
    #   userSettings = {
    #     "editor.tabSize" = 2;
    #     "editor.detectIndentation" = false;
    #     "breadcrumbs.enabled" = false;
    #     "explorer.confirmDragAndDrop" = false;
    #     "explorer.confirmDelete" = false;
    #     "extensions.ignoreRecommendations" = true;
    #     "editor.fontFamily" = "Fira Code";
    #     "editor.fontLigatures" = true;
    #     "explorer.confirmPasteNative" = false;
    #     "window.menuBarVisibility" = "hidden";
    #     "window.titleBarStyle" = "custom";
    #     "workbench.panel.defaultLocation" = "right";
    #     "workbench.colorTheme" = "Catppuccin Mocha";
    #     "workbench.iconTheme" = "Catppuccin Mocha";
    #     # "window.zoomLevel" = 2;
    #     "workbench.editor.showTabs" = false;
    #     "workbench.statusBar.visible" = true;
    #     "workbench.activityBar.visible" = false;
    #     "editor.minimap.enabled" = false;
    #     "editor.lightbulb.enabled" = false;
    #     "editor.overviewRulerBorder" = false;
    #     "terminal.integrated.showLinkHover" = false;
    #     "editor.showFoldingControls" = "never";
    #     "editor.scrollbar.horizontal" = "hidden";
    #     "editor.scrollbar.vertical" = "hidden";
    #     "window.controlsStyle" = "hidden";
    #     "window.customTitleBarVisibility" = "never";

    #     "apc.electron" = {
    #        "titleBarStyle" = "hiddenInset";
    #     };

    #     "workbench.colorCustomizations" = {
	   #     	"activityBar.background" = "#1e1e2e";
	   #     	"sideBar.background" = "#1e1e2e";
	   # 	    "titleBar.background" = "#1e1e2e";
	   # 	    "titleBar.activeBackground" = "#1e1e2e";
    #     };
    #   };
    # };
  };
}
