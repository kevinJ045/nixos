{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix?rev=ccc188e244e8fb3248e3c8f19f70280076bf1408";
    linux.url = "nixpkgs/668834f72c7a082bdb823d1367a9abea15ebfcad";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }@inputs: {
    nixosConfigurations = {
      Decile = nixpkgs.lib.nixosSystem {
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
              ];
            };
          }
        ];
      };
    };
  };
}
