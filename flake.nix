{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (self) outputs;

      mkHost =
        hostName: system:
        nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/${hostName}
            ./modules
          ];
          specialArgs = {
            inherit
              hostName
              inputs
              outputs
              system
              ;
          };
        };
    in
    {
      nixosConfigurations = {
        fledgeling = mkHost "fledgeling" "x86_64-linux";
        goldfish = mkHost "goldfish" "x86_64-linux";
        piglin = mkHost "piglin" "x86_64-linux";
        potato = mkHost "potato" "x86_64-linux";
        visionfive2 = mkHost "visionfive2" "riscv64-linux";
      };

      overlays = import ./overlays { inherit inputs; };
    };
}
