{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:nixos/nixos-hardware";
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

      hosts = {
        riscv64-linux = [ "drone" ];
        x86_64-linux = [
          "fledgeling"
          "goldfish"
          "piglin"
          "potato"
        ];
      };

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
      checks = lib.mapAttrs (
        _: hostNames:
        lib.listToAttrs (
          map (
            name: lib.nameValuePair name outputs.nixosConfigurations.${name}.config.system.build.toplevel
          ) hostNames
        )
      ) hosts;
      nixosConfigurations = lib.foldl' (
        accumulator: current:
        accumulator // lib.genAttrs hosts.${current} (hostName: mkHost hostName current)
      ) { } (lib.attrNames hosts);

      darwinConfigurations.mitsuko = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/mitsuko
          {
            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
        ];
      };

      overlays = import ./overlays { inherit inputs lib; };
    };
}
