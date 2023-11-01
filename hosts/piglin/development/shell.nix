{ lib, ... }:
{
  programs = {
    bash.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;

      config = {
        # Should be `0s` to disable timeout
        # See https://github.com/direnv/direnv/issues/1188
        global.warn_timeout = "69h";
      };
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

    tealdeer = {
      enable = true;

      settings = {
        updates.auto_update = true;
      };
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
