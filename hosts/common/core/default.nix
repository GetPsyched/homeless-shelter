{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  users.mutableUsers = false;
}
