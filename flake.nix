{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    flakey-devShells.url = "https://flakehub.com/f/GetPsyched/not-so-flakey-devshells/0.x.x.tar.gz";
    flakey-devShells.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ home-manager, nixpkgs, ... }:
    let
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/persist.nix
          ./modules/unfree.nix
          ./hosts/${hostName}
        ];
        specialArgs = { inherit hostName inputs; };
      };
    in
    {
      nixosConfigurations = {
        goldfish = mkHost "goldfish";
        piglin = mkHost "piglin";
      };

      devShell.x86_64-linux = import ./devShell.nix {
        flakey-devShell-pkgs = inputs.flakey-devShells.outputs.packages.x86_64-linux;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };
    };
}
