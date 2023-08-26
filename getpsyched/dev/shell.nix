{ lib, pkgs, ... }: {
  programs = {
    bash.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
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

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
