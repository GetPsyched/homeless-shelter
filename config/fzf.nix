{ config, ... }:
{
  home-manager.users.${config.mainuser}.programs.fzf = {
    enable = true;
	enableBashIntegration = true;
  };
}
