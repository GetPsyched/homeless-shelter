{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware.nix
    ./nix.nix
    ./tailscale.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  users.mutableUsers = false;
}
