{
  hjem.users.primary.rum.programs.zoxide = {
    enable = true;
    flags = [ "--cmd cd" ];
    integrations.zsh.enable = true;
  };
  persist.state.homeDirectories = [ ".local/share/zoxide" ];
}
