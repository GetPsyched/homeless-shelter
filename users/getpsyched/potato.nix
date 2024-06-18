{ ... }:
{
  imports = [
    ../../modules/home-manager

    ../common/core
  ];

  xdg.dataFile."warp/accepted-tos.txt".text = "yes";
}
