{
  programs.atlauncher.enable = true;
  programs.atlauncher.settings = {
    enableConsole = false;
    enableTrayMenu = false;
    firstTimeRun = false;
    keepLauncherOpen = false;
    theme = "com.atlauncher.themes.OneDark";
    useJavaProvidedByMinecraft = false;
  };

  persist.misc.homeDirectories = [ ".local/share/ATLauncher" ];
}
