{ config, lib, ... }:
{
  home-manager.users.${config.mainuser}.programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$character";
      right_format = lib.strings.concatStrings [
        "$cmd_duration"
        "$nix_shell"
      ];
      git_branch = {
        format = "\\([$branch](purple)\\) ";
      };
      character = {
        success_symbol = "[λ](yellow)";
        error_symbol = "[λ](red)";
      };
      directory.style = "cyan";
      nix_shell.format = "[$symbol](blue)";
    };
  };
}
