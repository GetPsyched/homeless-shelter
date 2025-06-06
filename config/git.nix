{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.primary.home.packages = [ pkgs.difftastic ];
  home-manager.users.primary.programs.git = {
    enable = true;
    extraConfig = {
      user.name = "GetPsyched";
      user.email = "priyanshu@getpsyched.dev";

      # difftastic
      diff.external = lib.getExe pkgs.difftastic;
      alias.dl = "log -p --ext-diff";
      alias.ds = "show --ext-diff";

      # signing
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.progam = lib.getExe' pkgs.openssh "ssh-keygen";
      user.signingKey = "${config.users.users.primary.home}/.ssh/id_ed25519.pub";

      advice.detachedHead = false;
      advice.mergeConflict = false;
      alias = {
        amend = "commit --amend --no-edit --date=now";
        co = "checkout";
        epic-fail = "reset --soft HEAD~1";
        fixup = "commit --fixup";
        squash = "!git reset --soft HEAD~1 && git commit --amend";

        # delete branch
        bye = "branch -d";
        nuke = "push origin -d";
      };
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
