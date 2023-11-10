{ pkgs, ... }:
{
  imports = [
    ./eww
    ./rofi
  ];

  home.packages = with pkgs; [ feh peek ];

  services = {
    flameshot = {
      enable = true;

      settings = {
        General = {
          checkForUpdates = false;
          disabledTrayIcon = true;
          saveLastRegion = true;
          showDesktopNotification = false;
          showStartupLaunchMessage = false;
          uploadWithoutConfirmation = true;
        };
      };
    };

    gammastep = {
      enable = true;
      temperature.day = 4500;
      temperature.night = 4500;
      duskTime = "18:35-20:15";
      dawnTime = "6:00-7:45";
    };

    random-background = {
      enable = true;
      imageDirectory = "%h/backgrounds";
      interval = "1h";
    };
  };
}
