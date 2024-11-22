{ config, ... }:
{
  home-manager.users.${config.mainuser} = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      # Should be `0s` to disable timeout
      # See https://github.com/direnv/direnv/issues/1188
      config.global.warn_timeout = "69h";
    };

    programs.git.ignores = [
      ".direnv"
      ".envrc"
    ];
  };
  persist.state.homeDirectories = [ ".local/share/direnv/allow" ];
}
