{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      hosts = {
        fledgeling = "x86_64-linux";
        goldfish = "x86_64-linux";
        piglin = "x86_64-linux";
        potato = "x86_64-linux";
      };
      forAllHosts = func: lib.mapAttrs' func hosts;

      mkHost =
        hostName: system:
        nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/${hostName}
            ./modules
            inputs.home-manager.nixosModules.default
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
      checks = forAllHosts (
        name: value:
        lib.nameValuePair value {
          ${name} = outputs.nixosConfigurations.${name}.config.system.build.toplevel;
        }
      );
      nixosConfigurations = forAllHosts (name: value: lib.nameValuePair name (mkHost name value));

      overlays = import ./overlays { inherit inputs; };
    };
}
