{ config, pkgs, ... }:
{
  users.users.primary.packages = [ pkgs.radicle-node ];
  home-manager.users.primary.home.file.".radicle/config.json".text = builtins.toJSON {
    node.alias = config.users.users.primary.name;
    preferredSeeds = [ "z6MktpwRwP7XDUaLEPWg8o859r9NJzhSvxBSN1rz7S5oAW7e@radicle.getpsyched.dev:8776" ];
  };
  persist.data.homeDirectories = [ ".radicle" ];
}
