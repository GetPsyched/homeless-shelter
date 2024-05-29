{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager

    ../common/core
  ];

  home.username = "getpsyched";

  xdg.dataFile."warp/accepted-tos.txt".text = "yes";
}
