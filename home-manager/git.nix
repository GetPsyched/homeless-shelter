{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "GetPsyched";
    userEmail = "priyanshutr@proton.me";

    extraConfig = {
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
