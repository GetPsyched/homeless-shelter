{
  persist.stateDirs = [ ".local/share/zed" ];

  programs.zed = {
    enable = true;

    settings = {
      theme = "Ayu Dark";
    };
  };
}
