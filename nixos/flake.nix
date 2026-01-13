{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix/release-25.05";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nix-software-center.url = "github:snowfallorg/nix-software-center";
    # zen-browser = {
      # url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # jovian.url = "github:jovian-experiments/jovian-nixos/development";
    # nixvim = {
      # url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-25.11";
    
      # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # quickshell = {
      # add ?ref=<tag> to track a tag
      # url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.11";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";
    # catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    # nvimdots.url = "github:ayamir/nvimdots";
  };
  outputs = inputs@{ nixpkgs, dankMaterialShell, home-manager, stylix, catppuccin, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          # jovian.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            # home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.extraSpecialArgs = { inherit nixvim; };
            home-manager.users.makano = {
              imports = [
                ./home.nix
                ./unknown.nix
                stylix.homeModules.stylix
                catppuccin.homeModules.catppuccin
               	dankMaterialShell.homeModules.dankMaterialShell.default
                # catppuccin.homeManagerModules.catppuccin
                # nvimdots.homeManagerModules.nvimdots
              ];
            };
          }
        ];
      };
    };
  };
}
