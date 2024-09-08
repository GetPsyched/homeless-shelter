{ pkgs, ... }:
{
  home.packages = with pkgs; [ feh ];

  services.flameshot = {
    enable = true;

    settings = {
      General = {
        disabledTrayIcon = true;
        saveLastRegion = true;
        showDesktopNotification = false;
        showStartupLaunchMessage = false;
        uploadWithoutConfirmation = true;
      };
    };
  };

  services.gammastep = {
    enable = true;
    temperature.day = 4500;
    temperature.night = 4500;
    duskTime = "18:35-20:15";
    dawnTime = "6:00-7:45";
  };
}
