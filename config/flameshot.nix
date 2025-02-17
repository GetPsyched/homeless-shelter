{ config, ... }:
{
  home-manager.users.primary.services.flameshot = {
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
}
