{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.primary.programs.git = {
    enable = true;
    userName = "GetPsyched";
    userEmail = "priyanshu@getpsyched.dev";

    difftastic.enable = true;
    difftastic.background = "dark";
    aliases.dl = "log -p --ext-diff";
    aliases.ds = "show --ext-diff";

    extraConfig = {
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.progam = lib.getExe' pkgs.openssh "ssh-keygen";
      user.signingKey = "${config.users.users.primary.home}/.ssh/id_ed25519.pub";

      alias = {
        amend = "commit --amend --no-edit --date=now";
        co = "checkout";
        epic-fail = "reset --soft HEAD~1";
        squash = "!git reset --soft HEAD~1 && git commit --amend";

        # delete branch
        bye = "branch -d";
        nuke = "push origin -d";
      };
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
}
