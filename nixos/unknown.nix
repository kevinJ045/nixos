{ config, lib, pkgs, quickshell, ... }:

let
  cfg = config.programs.quickshell;

  # prefer the external quickshellPkg if provided, else fallback to pkgs.quickshell
  quickshellPackage = quickshell;
in
{
  meta.maintainers = [ lib.maintainers.justdeeevin ];

  options.programs.quickshell = {
    enable = lib.mkEnableOption "QuickShell, a flexible QtQuick-based desktop shell toolkit.";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.emptyDirectory;
      description = "Fake QuickShell package placeholder";
    };

    configs = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = { };
      description = ''
        A set of configs to include in the quickshell config directory.
        The key is the name of the config.
        The configuration QuickShell should use can be specified with `activeConfig`.
      '';
    };

    activeConfig = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        The name of the config to use.
        If `null`, QuickShell will attempt to use a config located in `$XDG_CONFIG_HOME/quickshell`.
      '';
    };

    systemd = {
      enable = lib.mkEnableOption "QuickShell systemd service";
      target = lib.mkOption {
        type = lib.types.str;
        default = config.wayland.systemd.target;
        defaultText = lib.literalExpression "config.wayland.systemd.target";
        example = "hyprland-session.target";
        description = ''
          The systemd target that will automatically start QuickShell.
          Typically your Wayland compositor session target.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (cfg.configs != { }) {
        xdg.configFile = lib.mapAttrs' (name: path: {
          name = "quickshell/${name}";
          value.source = path;
        }) cfg.configs;
      })

      {
        assertions = [
          (lib.hm.assertions.assertPlatform "programs.quickshell" pkgs lib.platforms.linux)
          {
            assertion = !(builtins.any (name: lib.hasInfix "/" name) (builtins.attrNames cfg.configs));
            message = "Config names in `programs.quickshell.configs` must not contain slashes.";
          }
        ];

        # home.packages = [ cfg.package or quickshellPackage ];
      }

      (lib.mkIf cfg.systemd.enable {
        systemd.user.services.quickshell = {
          Unit = {
            Description = "QuickShell";
            Documentation = "https://quickshell.outfoxxed.me/docs/";
            After = [ cfg.systemd.target ];
          };

          Service = {
            ExecStart =
              lib.getExe (cfg.package or quickshellPackage)
              + (if cfg.activeConfig == null then "" else " --config ${cfg.activeConfig}");
            Restart = "on-failure";
          };

          Install.WantedBy = [ cfg.systemd.target ];
        };
      })
    ]
  );
}
