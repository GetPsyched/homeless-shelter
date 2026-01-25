{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hjem.follows = "hjem-rum/hjem";
    hjem-rum.url = "github:getpsyched/hjr-wrapped/queued";
    hjem-rum.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "";
    impermanence.inputs.home-manager.follows = "";

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
              ]
              ++ modules;
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
