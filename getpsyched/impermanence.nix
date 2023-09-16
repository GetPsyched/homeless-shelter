{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

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
        ".config/VSCodium"
        ".local/share/applications"
        ".local/share/direnv/allow"
        ".minecraft"
        ".mozilla/firefox/main"
        ".railway"
        ".rustup"
        ".steam"
      ];
      files = [
        ".local/share/nix/trusted-settings.json"
      ];
      allowOther = true;
    };

    "/persist/bigdata/home/getpsyched" = {
      directories = [
        ".local/share/Steam"
        ".heroic"
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
