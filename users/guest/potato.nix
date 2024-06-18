{
  imports = [
    ../../modules/home-manager

    ../common/core
  ];

  home.username = "guest";

  xdg.dataFile."warp/accepted-tos.txt".text = "yes";
}
