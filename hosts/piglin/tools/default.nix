{ pkgs, ... }:
{
  imports = [
    ./eww
    ./rofi
  ];

  home.packages = with pkgs; [ feh peek ];

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          font = "Roboto Mono 8";
          width = 300;
          origin = "top-right";
          offset = "40x50";
          transparency = 0;
          frame_width = 2;
          separator_height = 2;
          sort = true;
        };
        urgency_low = {
          background = "#191919";
          foreground = "#BBBBBB";
        };
        urgency_normal = {
          background = "#191919";
          foreground = "#BBBBBB";
        };
        urgency_critical = {
          background = "#191919";
          foreground = "#DE6E7C";
        };
      };
    };

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
