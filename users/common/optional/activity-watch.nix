{
  persist.stateDirs = [ ".local/share/activitywatch" ];

  services.activitywatch = {
    enable = true;
  };
}
