{ config, pkgs, ... }:
{
  home-manager.users.${config.mainuser} = {
    home.packages = [ pkgs.github-cli ];

    persist.src = [ "src" ];
    persist.secretsDirs = [ ".ssh" ];
    persist.stateFiles = [ ".config/gh/hosts.yml" ];

    programs.git = {
      enable = true;
      userName = "GetPsyched";
      userEmail = "priyanshu@getpsyched.dev";

      aliases = {
        amend = "commit --amend --no-edit --date=now";
        co = "checkout";
        epic-fail = "reset --soft HEAD~1";
        squash = "!git reset --soft HEAD~1 && git commit --amend";

        # delete branch
        bye = "branch -d";
        nuke = "push origin -d";
      };

      difftastic.enable = true;
      difftastic.background = "dark";
      aliases.dshow = "show --ext-diff";

      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingKey = "~/.ssh/id_ed25519.pub";

        advice.mergeConflict = false;
        core.fsmonitor = true;
        core.untrackedCache = true;
        core.whitespace = "trailing-space,space-before-tab";
        init.defaultBranch = "master";
        merge.conflictstyle = "diff3";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}
