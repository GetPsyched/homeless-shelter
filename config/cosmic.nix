{ config, pkgs, ... }:
{
  services.desktopManager.cosmic.enable = true;
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = config.users.users.primary.name;
    cosmic-greeter.enable = true;
  };

  environment.cosmic.excludePackages = [
    pkgs.cosmic-edit
    pkgs.cosmic-screenshot
    pkgs.cosmic-term
    pkgs.cosmic-wallpapers
  ];

  # Needed by apps like Flameshot
  # TODO: Remove when using cosmic from HM
  home-manager.users.primary.systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  persist.state.homeDirectories = [ ".config/cosmic" ];
}
