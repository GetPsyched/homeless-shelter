{ config, pkgs, ... }:
{
  # environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  hjem.users.primary.rum.programs.zsh = {
    enable = true;
  };
  persist.state.homeFiles = [
    ".bash_history"
    ".zsh_history"
  ];
}
