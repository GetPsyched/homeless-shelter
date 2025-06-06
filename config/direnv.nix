{ config, ... }:
{
  home-manager.users.primary = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      config.global.warn_timeout = "0s";
    };

    programs.git.ignores = [
      ".direnv"
      ".envrc"
    ];
  };
  persist.state.homeDirectories = [ ".local/share/direnv/allow" ];
}
