{ pkgs, ... }: {
  home.packages = [ github-cli ];

  programs.git = {
    enable = true;
    userName = "GetPsyched";
    userEmail = "priyanshutr@proton.me";

    aliases = {
      amend = "commit --amend --no-edit";
      epic-fail = "reset HEAD~1";
    };

    extraConfig = {
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
