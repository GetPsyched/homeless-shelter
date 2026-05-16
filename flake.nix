{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-hytale.url = "github:nixos/nixpkgs/refs/pull/479368/head";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    hjem.follows = "hjem-rum/hjem";
    hjem-rum.url = "github:getpsyched/hjr-wrapped/queued";
    hjem-rum.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence/refs/pull/329/head";
    impermanence.inputs.nixpkgs.follows = "";
    impermanence.inputs.home-manager.follows = "";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      ...
    }:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      systems = {
        aarch64-darwin = [ "mitsuko" ];
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
            darwin = nix-darwin.lib.darwinSystem;
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

      nixosConfigurations = mkConfigurations "linux" [
        inputs.hjem.nixosModules.default
        ./modules/steward/nixos.nix
      ];
      darwinConfigurations = mkConfigurations "darwin" [
        inputs.hjem.darwinModules.default
        {
          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
        ./modules/steward/darwin.nix
      ];

      overlays = import ./overlays { inherit inputs lib; };
    };
}
