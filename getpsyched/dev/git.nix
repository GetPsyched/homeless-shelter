{ pkgs, ... }: {
  home.packages = [ pkgs.github-cli ];

  programs.git = {
    enable = true;
    userName = "GetPsyched";
    userEmail = "priyanshutr@proton.me";

    aliases = {
      amend = "commit --amend --no-edit";
      co = "checkout";
      epic-fail = "reset HEAD~1";
    };

    ignores = [ ".direnv" ];

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";

      core.whitespace = "trailing-space,space-before-tab";
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
