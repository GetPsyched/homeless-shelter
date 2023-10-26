{
  description = "GetPsyched's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    impermanence.url = "github:nix-community/impermanence";

    nix-env.url = "github:GetPsyched/nix-starter-flakes?dir=nix";
    nix-env.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ff-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    ff-addons.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { nixpkgs, nix-env, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      nix-env-pkgs = nix-env.outputs.packages.${system};
    in
    {
      nixosConfigurations.piglin = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/unfree.nix
          ./hosts/piglin/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.getpsyched = import ./hosts/piglin/home.nix;
            };
          }
        ];
      };
      devShell.${system} = with pkgs; mkShell {
        buildInputs = [
          nix-env-pkgs.default
          (nix-env-pkgs.vscode.override {
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
          just
        ];
      };
    };
}
