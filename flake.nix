{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          modules = [
            ./modules/persist.nix
            ./modules/unfree.nix
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
