{ config, ... }:
{
  home-manager.users.primary.programs.fzf = {
    enable = true;
	enableBashIntegration = true;
  };
}
