{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    # nvimdots.url = "github:ayamir/nvimdots";
  };
	# nvimdots
  outputs = inputs@{ nixpkgs, home-manager, catppuccin, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.makano = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
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
