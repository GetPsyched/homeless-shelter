{
  imports = [
    ./sway

    ./notificationd.nix
  ];

  home.file.".config/rofi/config.rasi".source = ./menu.rasi;
  home.file.".config/rofi/power-menu.rasi".source = ./rofi-power-menu.rasi;
  home.file.".config/rofi/power-menu.sh".source = ./rofi-power-menu.sh;
}
