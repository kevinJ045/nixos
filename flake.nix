{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
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
                catppuccin.homeManagerModules.catppuccin
                # nvimdots.homeManagerModules.nvimdots
              ];
            };
          }
        ];
      };
    };
  };
}
