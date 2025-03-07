{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$character";
      right_format = "$cmd_duration$time$nix_shell";
      cmd_duration.min_time = 0;
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
