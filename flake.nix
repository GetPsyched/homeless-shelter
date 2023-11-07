{
  description = "GetPsyched's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ff-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    ff-addons.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    flakey-devShells.url = "https://flakehub.com/f/GetPsyched/not-so-flakey-devshells/0.x.x.tar.gz";
    flakey-devShells.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      mkHost = hostName: system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./modules/unfree.nix
          ./hosts/${hostName}/configuration.nix
        ] ++ nixpkgs.lib.optionals (builtins.pathExists ./hosts/${hostName}/home.nix)
          [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.getpsyched = import ./hosts/${hostName}/home.nix;
              };
            }
          ];
      };
    in
    {
      nixosConfigurations = {
        piglin = mkHost "piglin" "x86_64-linux";
      };

      devShell.${system} = with pkgs; mkShell {
        nativeBuildInputs =
          let
            flakey-devShell-pkgs = inputs.flakey-devShells.outputs.packages.${system};
          in
          [
            just

            flakey-devShell-pkgs.default
            (flakey-devShell-pkgs.vscodium.override {
              extensions = with vscode-extensions; [
                foxundermoon.shell-format
              ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                  name = "rasi";
                  publisher = "dlasagno";
                  version = "1.0.0";
                  sha256 = "sha256-s60alej3cNAbSJxsRlIRE2Qha6oAsmcOBbWoqp+w6fk=";
                }
                {
                  name = "vscode-parinfer";
                  publisher = "shaunlebron";
                  version = "0.6.2";
                  sha256 = "sha256-zev0oomPf9B+TaNRnp4xcmEWJBaa+IHgysbX2G0mm0A=";
                }
                {
                  name = "yuck";
                  publisher = "eww-yuck";
                  version = "0.0.3";
                  sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
                }
              ];
            })
          ];
      };
    };
}
