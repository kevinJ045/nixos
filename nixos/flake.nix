{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix/25.05";
    # nix-software-center.url = "github:snowfallorg/nix-software-center";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # jovian.url = "github:jovian-experiments/jovian-nixos/development";
    caelestia-shell-src = {
      url = "github:caelestia-dots/shell";
      flake = false; # This is the crucial part
    };
    nixvim = {
      # url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-25.05";
    
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    # nvimdots.url = "github:ayamir/nvimdots";
  };
  outputs = inputs@{ nixpkgs, home-manager, stylix, nixvim, catppuccin, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          # jovian.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs nixvim; };
            home-manager.users.makano = {
              imports = [
                ./home.nix
                stylix.homeModules.stylix
                catppuccin.homeModules.catppuccin
               	# nixvim.homeManagerModules.nixvim
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
