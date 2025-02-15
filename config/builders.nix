{ config, ... }:
{
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "build-box.nix-community.org";
      maxJobs = 12;
      protocol = "ssh-ng";
      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEg=";
      sshKey = "${config.users.users.${config.mainuser}.home}/.ssh/id_ed25519";
      sshUser = config.mainuser;
      supportedFeatures = [
        "benchmark"
        "big-parallel"
        "gccarch-broadwell"
        "gccarch-haswell"
        "gccarch-ivybridge"
        "gccarch-nehalem"
        "gccarch-sandybridge"
        "gccarch-skylake"
        "gccarch-westmere"
        "gccarch-x86-64"
        "gccarch-x86-64-v2"
        "gccarch-x86-64-v3"
        "gccarch-znver1"
        "gccarch-znver2"
        "kvm"
        "nixos-test"
        "uid-range"
      ];
      systems = [
        "x86_64-linux"

        # extra-platforms
        "i686-linux"
        "riscv64-linux"
        "x86_64-v1-linux"
        "x86_64-v2-linux"
        "x86_64-v3-linux"
      ];
    }
  ];
}
