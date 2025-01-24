{
  programs.zed.enable = true;
  programs.zed.settings = {
    assistant = {
      version = "1";
      provider = {
        default_model = "claude-3-5-sonnet";
        name = "anthropic";
        low_speed_timeout_in_seconds = 60;
      };
    };

    theme = "Ayu Dark";
  };

  persist.state.homeDirectories = [ ".local/share/zed" ];
}
