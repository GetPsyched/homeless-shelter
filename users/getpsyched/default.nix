{ hostName, lib, pkgs, ... }:
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

  home-manager.users.getpsyched = lib.recursiveUpdate
    {
      home = {
        username = "getpsyched";
        pointerCursor = {
          name = "Banana";
          size = 48;
          package = pkgs.banana-cursor;
          x11.enable = true;
          gtk.enable = true;
        };
      };
    }
    (import ./${hostName}.nix { inherit pkgs; });

  allowUnfreePackages = [
    "obsidian"
    "osu-lazer-bin"
    "spotify"
  ];
}
