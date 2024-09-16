{
  persist.stateDirs = [ ".local/share/zed" ];

  programs.zed = {
    enable = true;

    settings = {
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
  };
}
