{
  imports = [
    ./i3.nix
    ./notificationd.nix
    ./polybar.nix
  ];

  home.file.".config/rofi/config.rasi".source = ./menu.rasi;
  home.file.".config/rofi/power-menu.rasi".source = ./rofi-power-menu.rasi;
  home.file.".config/rofi/power-menu.sh".source = ./rofi-power-menu.sh;
}
