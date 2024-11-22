{ config, ... }:
{
  home-manager.users.${config.mainuser} = {
    home.file.".config/rofi/config.rasi".source = ./config.rasi;
    home.file.".config/rofi/power-menu.rasi".source = ./power-menu.rasi;
    home.file.".config/rofi/power-menu.sh".source = ./power-menu.sh;
  };
}
