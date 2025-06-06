{ config, ... }:
{
  home-manager.users.primary = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      config = {
        global.warn_timeout = "0s";
        whitelist.prefix = [ "~/src" ];
      };
    };

    programs.git.ignores = [
      ".direnv"
      ".envrc"
    ];
  };
}
