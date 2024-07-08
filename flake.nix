{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    inputs@{ nixpkgs, nixos-cosmic, ... }:
    let
      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/persist.nix
            ./modules/unfree.nix
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            ./hosts/${hostName}
          ];
          specialArgs = {
            inherit hostName inputs;
          };
        };
    in
    {
      nixosConfigurations = {
        goldfish = mkHost "goldfish";
        piglin = mkHost "piglin";
        potato = mkHost "potato";
      };

      devShells.x86_64-linux.default =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell { nativeBuildInputs = [ pkgs.just ]; };
    };
}
