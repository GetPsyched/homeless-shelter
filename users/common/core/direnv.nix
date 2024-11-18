{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config = {
      # Should be `0s` to disable timeout
      # See https://github.com/direnv/direnv/issues/1188
      global.warn_timeout = "69h";
    };
  };
  # persist.state.homeDirectories = [ ".local/share/direnv/allow" ];
}
