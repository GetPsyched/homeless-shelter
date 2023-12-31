{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  xdg.dataFile."warp/accepted-tos.txt".text = "yes";

  home.persistence = {
    "/persist/bigdata/home/getpsyched" = {
      directories = [
        ".local/share/ATLauncher"
        ".heroic"
        ".steam-games"
        "My Games"
      ];
      allowOther = true;
    };

    "/var/cache/home/getpsyched" = {
      directories = [
        ".cache"
      ];
      allowOther = true;
    };
  };
}
