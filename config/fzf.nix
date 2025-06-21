{ config, ... }:
{
  home-manager.users.primary.programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
