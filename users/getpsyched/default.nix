{ hostName, ... }:
{
  users.users.getpsyched = {
    isNormalUser = true;
    description = "Priyanshu Tripathi";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
  };

  home-manager.users.getpsyched = import ./${hostName}.nix;

  allowUnfreePackages = [
    "obsidian"
    "osu-lazer-bin"
    "spotify"
  ];
}
