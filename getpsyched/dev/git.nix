{ pkgs, ... }: {
  home.packages = [ pkgs.github-cli ];

  programs.git = {
    enable = true;
    userName = "GetPsyched";
    userEmail = "priyanshutr@proton.me";

    aliases = {
      amend = "commit --amend --no-edit";
      # TODO: convert `upstream` and `master` to variables
      catch-up = "git fetch upstream && git rebase upstream/master && git push";
      epic-fail = "reset HEAD~1";
    };

    extraConfig = {
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
