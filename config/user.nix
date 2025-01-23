{ config, ... }:
{
  imports = [ ./home.nix ];

  persist.cache.homeDirectories = [ ".cache" ];

  users.mutableUsers = false;
  users.users.${config.mainuser} = {
    description = "Priyanshu Tripathi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
    home = "/home/${config.mainuser}";
    isNormalUser = true;
  };
}
