{
  hjem.users.primary.rum.programs.fzf = {
    enable = true;
    integrations.zsh.enable = true;
  };
  environment.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd --type f";
    FZF_DEFAULT_OPTS = "--height 40% --layout reverse --border";
  };
}
