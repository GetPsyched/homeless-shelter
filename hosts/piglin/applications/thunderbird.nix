{
  persist.stateDirs = [ ".thunderbird/main" ];

  programs.thunderbird = {
    enable = true;

    profiles.main = {
      isDefault = true;
    };
  };
}
