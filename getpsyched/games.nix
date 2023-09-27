{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gamemode
    heroic
    mangohud
    osu-lazer-bin

    (pkgs.callPackage ../packages/atlauncher.nix { })
  ];

  xdg.desktopEntries = {
    rocket-league = {
      categories = [ "Game" ];
      exec = "xdg-open heroic://launch/legendary/Sugar";
      icon = "/home/getpsyched/.config/heroic/icons/Sugar.jpg";
      name = "Rocket League";
      terminal = false;
      type = "Application";
    };
  };
}
