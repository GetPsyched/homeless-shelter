{
  description = "GetPsyched's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = { inherit inputs; };
          # home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.getpsyched.imports = [ ./home-manager/home.nix ];
        }
      ];
    };

    homeConfigurations = {
      "getpsyched@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
