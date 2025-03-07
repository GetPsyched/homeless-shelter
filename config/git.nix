{ config, pkgs, ... }:
{
  home-manager.users.primary = {
    home.packages = [ pkgs.github-cli ];

    programs.git = {
      enable = true;
      userName = "GetPsyched";
      userEmail = "priyanshu@getpsyched.dev";

      signing = {
        format = "ssh";
        key = "${config.users.users.primary.home}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };

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
      aliases.dl = "log -p --ext-diff";
      aliases.ds = "show --ext-diff";

      extraConfig = {
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
  persist.state.homeFiles = [ ".config/gh/hosts.yml" ];
}
