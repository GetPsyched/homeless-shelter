{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  xdg.dataFile."warp/accepted-tos.txt".text = "yes";
}
