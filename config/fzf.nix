{ lib, pkgs, ... }:
{
  hjem.users.primary.rum.programs.fzf = {
    enable = true;
    env = {
      DEFAULT_COMMAND = "${lib.getExe pkgs.fd} --type f";
      DEFAULT_OPTS = "--height 40% --layout reverse --border";
    };
  };
}
