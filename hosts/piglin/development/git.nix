{ pkgs, ... }:
{
  home.packages = [ pkgs.github-cli ];

  persist.src = [ "src" ];
  persist.secretsDirs = [ ".ssh" ];
  persist.stateFiles = [ ".config/gh/hosts.yml" ];

  programs.git = {
    enable = true;
    userName = "GetPsyched";
    userEmail = "priyanshu@getpsyched.dev";

    aliases = {
      amend = "commit --amend --no-edit";
      co = "checkout";
      epic-fail = "reset HEAD~1";

      # delete branch
      bye = "branch -d";
      nuke = "push origin -d";
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
