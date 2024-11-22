{ config, ... }:
{
  home-manager.users.${config.mainuser}.programs.atlauncher = {
    enable = true;
    theme = "One Dark";

    settings = {
      enableConsole = false;
      enableTrayMenu = false;
      firstTimeRun = false;
      keepLauncherOpen = false;
      useJavaProvidedByMinecraft = false;
    };
  };
  persist.misc.homeDirectories = [ ".local/share/ATLauncher" ];
}
