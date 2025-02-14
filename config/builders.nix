{ config, ... }:
{
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "build-box.nix-community.org";
      protocol = "ssh-ng";
      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEg=";
      sshKey = "${config.users.users.${config.mainuser}.home}/.ssh/id_ed25519";
      sshUser = config.mainuser;
      supportedFeatures = [ "big-parallel" ];
      systems = [ "x86_64-linux" ];
    }
  ];
}
