{ config, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  home-manager.users.primary.programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      path = "${config.users.users.primary.home}/.local/state/zsh/history";
    };
    initContent = ''
      autoload -Uz zmv
    '';
  };

  persist.state.homeDirectories = [ ".local/state/zsh" ];
  persist.state.homeFiles = [ ".bash_history" ]; # Keeping this around for a bit
}
