{
  description = "GetPsyched's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    impermanence.url = "github:nix-community/impermanence";

    nix-env.url = "https://flakehub.com/f/GetPsyched/nix-env/0.x.x.tar.gz";
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
    in
    {
      nixosConfigurations.potato = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.getpsyched.imports = [ ./getpsyched ];
          }
        ];
      };
      devShell.${system} = with pkgs; mkShell {
        buildInputs = [
          nix-env.outputs.packages.${system}.default
          nix-env.outputs.packages.${system}.vscode
          just
        ];
      };
    };
}
