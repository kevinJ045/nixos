
# In your home.nix
{ config, lib, pkgs, inputs, ... }: # Ensure 'inputs' is passed from your flake.nix

let
  # Define the package directly here.
  # `inputs.caelestia-shell-src` is not a flake, but a path to the source code.
  caelestia-shell-config-pkg = pkgs.stdenv.mkDerivation {
    pname = "caelestia-shell-config";
    version = "git";

    # Use the input directly as the source.
    src = inputs.caelestia-shell-src;

    # The install logic is the same as before.
    installPhase = ''
      runHook preInstall
      install -d $out/share/quickshell/caelestia
      cp -r ./* $out/share/quickshell/caelestia/
      runHook postInstall
    '';

    meta = {
      description = "The configuration files for the Caelestia shell";
      homepage = "https://github.com/caelestia-dots/shell";
    };
  };
in
{
  # 1. Install quickshell, its dependencies, and our new local package.
  home.packages = with pkgs; [
    inputs.unstable.legacyPackages.${pkgs.system}.quickshell
    caelestia-shell-config-pkg # Use the package we just defined above

    # Dependencies
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    qt5.qtmultimedia
    material-symbols
    # kdePackages.breeze-icons
    kdePackages.kwayland
  ];

  # 2. Point quickshell to the configuration's location.
  home.sessionVariables = {
   XDG_CONFIG_DIRSi_2 = "${caelestia-shell-config-pkg}/share:$XDG_CONFIG_DIRS";
  };
}
