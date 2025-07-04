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

      systems = {
        riscv64-linux = [ "drone" ];
        x86_64-linux = [
          "fledgeling"
          "goldfish"
          "piglin"
          "potato"
        ];
      };

      mkConfigurations =
        os: modules:
        let
          filteredSystems = lib.filterAttrs (system: _: lib.hasSuffix "-${os}" system) systems;
          systemBuilders = {
            linux = nixpkgs.lib.nixosSystem;
          };
        in
        lib.foldl' (
          accumulator: current:
          accumulator
          // lib.genAttrs filteredSystems.${current} (
            hostName:
            systemBuilders.${os} {
              modules = [
                ./hosts/${hostName}
                ./modules
                inputs.home-manager.nixosModules.default
              ] ++ modules;
              specialArgs = {
                inherit hostName inputs outputs;
                system = current;
              };
            }
          )
        ) { } (lib.attrNames filteredSystems);
    in
    {
      checks = lib.mapAttrs (
        _: hostNames:
        lib.listToAttrs (
          map (
            name: lib.nameValuePair name outputs.nixosConfigurations.${name}.config.system.build.toplevel
          ) hostNames
        )
      ) systems;

      nixosConfigurations = mkConfigurations "linux" [ ];

      overlays = import ./overlays { inherit inputs lib; };
    };
}
