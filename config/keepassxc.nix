{
  programs.keepassxc.enable = true;
  programs.keepassxc.settings = {
    Browser = {
      Enabled = true;
      SearchInAllDatabases = true;
    };
    GUI.ApplicationTheme = "dark";
    Security.LockDatabaseIdleSeconds = 60;
  };
}
