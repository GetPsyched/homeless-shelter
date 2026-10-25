{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-hytale.url = "github:nixos/nixpkgs/refs/pull/479368/head";

    hjem.follows = "hjem-rum/hjem";
    hjem-rum.url = "github:getpsyched/hjr-wrapped/queued";
    hjem-rum.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence/refs/pull/329/head";
    impermanence.inputs.nixpkgs.follows = "";
    impermanence.inputs.home-manager.follows = "";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    systems = {
      riscv64-linux = ["drone"];
      x86_64-linux = ["goldfish" "piglin" "potato"];
    };
    forAllSystems = lib.genAttrs (builtins.attrNames systems);

    mkConfigurations = os: modules: let
      filteredSystems = lib.filterAttrs (system: _: lib.hasSuffix "-${os}" system) systems;
      systemBuilders = {
        linux = nixpkgs.lib.nixosSystem;
      };
    in
      lib.foldl' (accumulator: current:
        accumulator
        // lib.genAttrs filteredSystems.${current} (
          hostName:
            systemBuilders.${os} {
              modules =
                [
                  {
                    networking.hostName = hostName;
                    nixpkgs.hostPlatform = current;
                  }
                  ./hosts/${hostName}
                  ./modules
                ]
                ++ modules;
              specialArgs = {inherit inputs;};
            }
        )) {} (lib.attrNames filteredSystems);
  in {
    checks = forAllSystems (system:
      lib.listToAttrs (map (
          name: lib.nameValuePair name outputs.nixosConfigurations.${name}.config.system.build.toplevel
        )
        systems.${system}));

    nixosConfigurations = mkConfigurations "linux" [];

    overlays = import ./overlays {inherit inputs lib;};

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
