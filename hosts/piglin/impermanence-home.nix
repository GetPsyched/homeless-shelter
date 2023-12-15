{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  xdg.dataFile."warp/accepted-tos.txt".text = "yes";

  home.persistence = {
    "/persist/data/home/getpsyched" = {
      directories = [
        ".ssh"
        "backgrounds"
        "git"
        "iso"
        "obsidian-vault"
      ];
      allowOther = true;
    };

    "/persist/state/home/getpsyched" = {
      directories = [
        ".config/heroic"
        ".config/obsidian"
        ".config/spotify"
        ".local/share/applications"
        ".local/share/digikam"
        ".local/share/direnv/allow"
        ".local/share/Steam"
        ".local/share/zoxide"
        ".mozilla/firefox/main"
        ".railway"
        ".rustup"
        ".steam"
        ".thunderbird/main"
      ];
      files = [
        ".config/digikamrc"
        ".config/gh/hosts.yml"
        ".local/share/nix/trusted-settings.json"
      ];
      allowOther = true;
    };

    "/persist/bigdata/home/getpsyched" = {
      directories = [
        ".local/share/ATLauncher"
        ".heroic"
        ".steam-games"
        "My Games"
      ];
      allowOther = true;
    };

    "/var/cache/home/getpsyched" = {
      directories = [
        ".cache"
      ];
      allowOther = true;
    };
  };
}
