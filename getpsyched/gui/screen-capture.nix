{ pkgs, ... }: {
  home.packages = [ pkgs.peek ];

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

  systemd.user.services.flameshot.Unit.After = [
    "graphical-session-pre.target"
  ];
}
