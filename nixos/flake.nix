{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    # jovian.url = "github:jovian-experiments/jovian-nixos/development";
    stylix.url = "github:danth/stylix/release-25.05";
    # nvimdots.url = "github:ayamir/nvimdots";
    mnw.url = "github:gerg-l/mnw";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      catppuccin,
      ...
    }@inputs:
    {
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
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.makano = {
                imports = [
                  ./home.nix
                  stylix.homeModules.stylix
                  catppuccin.homeModules.catppuccin
                  inputs.mnw.homeManagerModules.default
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
