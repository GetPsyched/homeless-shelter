{
  hjem.users.primary.rum.programs.direnv = {
    enable = true;

    settings = {
      global.warn_timeout = "0s";
      whitelist.prefix = [ "~/src" ];
    };

    direnvrc = ''
      : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
        local hash path
        echo "''${direnv_layout_dirs[$PWD]:=$(
          hash="$(sha1sum - <<< "$PWD" | head -c40)"
          path="''${PWD//[^a-zA-Z0-9]/-}"
          echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
        )}"
      }
    '';
  };

  persist.cache.homeDirectories = [ ".cache/direnv/layouts" ];
}
