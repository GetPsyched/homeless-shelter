{ pkgs, ... }: {
  services.flameshot = {
    enable = true;

    settings = {
      General = {
        disabledTrayIcon = true;
        showDesktopNotification = false;
        showStartupLaunchMessage = false;
      };
    };
  };
}
