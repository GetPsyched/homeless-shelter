{ config, ... }:
{
  persist.cache.homeDirectories = [ ".cache" ];

  users.mutableUsers = false;
  users.users.primary = {
    description = "Priyanshu Tripathi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
    home = "/home/${config.users.users.primary.name}";
    isNormalUser = true;
    name = "getpsyched";
    openssh.authorizedKeys.keyFiles = [
      "${config.users.users.primary.home}/.ssh/id_ed25519.pub"
    ];
  };
}
