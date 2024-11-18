{
  programs.thunderbird = {
    enable = true;

    profiles.main = {
      isDefault = true;
    };
  };
  persist.state.directories = [ ".thunderbird/main" ];
}
