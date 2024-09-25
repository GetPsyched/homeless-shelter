{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/impermanence/issues/215
    impermanence.url = "github:nix-community/impermanence/63f4d0443e32b0dd7189001ee1894066765d18a5";

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
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            ./hosts/${hostName}
          ];
          specialArgs = {
            inherit hostName inputs;
          };
        };
    in
    {
      nixosConfigurations = {
        fledgeling = mkHost "fledgeling";
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
