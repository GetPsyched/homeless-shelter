{
  programs.thunderbird = {
    enable = true;

    profiles.main = {
      isDefault = true;
    };
  };
  # persist.state.homeDirectories = [ ".thunderbird/main" ];
}
