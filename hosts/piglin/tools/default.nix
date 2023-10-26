{ pkgs, ... }:
{
  impports = [ ./eww ];

  home.packages = with pkgs; [ feh peek ];

  services = {
    flameshot = {
      enable = true;

      settings = {
        General = {
          disabledTrayIcon = true;
          showDesktopNotification = false;
          showStartupLaunchMessage = false;
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
