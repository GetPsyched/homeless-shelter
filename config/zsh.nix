{ config, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  home-manager.users.primary.programs.zsh = {
    enable = true;
    initContent = ''
      HISTFILE="${config.users.users.primary.home}/.local/state/zsh/history"
      HISTSIZE=10000
      SAVEHIST=10000

      setopt EXTENDED_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt SHARE_HISTORY

      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      ZSH_AUTOSUGGEST_STRATEGY=(history)

      autoload -Uz zmv
    '';
  };

  persist.state.homeDirectories = [ ".local/state/zsh" ];
  persist.state.homeFiles = [ ".bash_history" ]; # Keeping this around for a bit
}
