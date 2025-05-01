{ config, pkgs, lib, ... }:

let
  extensionPath = ".local/share/gnome-shell/extensions/topbar-toggle@makano";
in
{

  home.activation.ensureGnomeExtensionDirs = lib.hm.dag.entryBefore ["writeBoundary"] ''
      mkdir -p "${config.home.homeDirectory}/${extensionPath}/schemas"
  '';
  
  home.file."${extensionPath}/metadata.json".text = ''
    {
      "uuid": "topbar-toggle@makano",
      "name": "Top Bar Toggle",
      "description": "Toggle visibility of GNOME top panel with a hotkey",
      "shell-version": ["45", "44", "43", "42"],
      "version": 1,
      "settings-schema": "org.gnome.shell.extensions.topbar-toggle"
    }
  '';

  home.file."${extensionPath}/extension.js".text = ''
    const { Gio, Shell, Meta } = imports.gi;
    const Main = imports.ui.main;
    let visible = true;

    function toggleTopBar() {
        visible = !visible;
        Main.panel.actor.visible = visible;
    }

    function enable() {
        global.display.add_keybinding(
            'toggle-shortcut',
            new Gio.Settings({ schema_id: 'org.gnome.shell.extensions.topbar-toggle' }),
            Meta.KeyBindingFlags.NONE,
            Shell.ActionMode.ALL,
            toggleTopBar
        );
    }

    function disable() {
        global.display.remove_keybinding('toggle-shortcut');
        Main.panel.actor.visible = true;
    }
  '';

  home.file."${extensionPath}/schemas/org.gnome.shell.extensions.topbar-toggle.gschema.xml".text = ''
    <schemalist>
      <schema id="org.gnome.shell.extensions.topbar-toggle" path="/org/gnome/shell/extensions/topbar-toggle/">
        <key name="toggle-shortcut" type="s">
          <default>'<Super><Shift>b'</default>
          <summary>Keybinding to toggle the top bar</summary>
        </key>
      </schema>
    </schemalist>
  '';

  # Compile schema on activation
  home.activation.gschemaCompile = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Compiling gschema for custom GNOME extension..."
    ${pkgs.glib.dev}/bin/glib-compile-schemas ${config.home.homeDirectory}/${extensionPath}/schemas
  '';
}
