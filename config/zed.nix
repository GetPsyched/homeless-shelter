{
  hjem.users.primary.rum.programs.zed = {
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
      # Explicitly setting this stops the auto-install of LSPs
      language_servers = [ ];
      theme = "Ayu Dark";
    };
  };

  persist.state.homeDirectories = [ ".local/share/zed" ];
}
