{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  # environment.etc."fuse.conf".text = ''
  #   user_allow_other
  # '';

  home.persistence = {
    "/persist/data/home/getpsyched" = {
      directories = [
        ".ssh"
        "backgrounds"
        "git"
        "obsidian-vault"
      ];
      allowOther = true;
    };

    "/persist/state/home/getpsyched" = {
      directories = [
        ".config/Code"
        ".config/legendary"
        ".config/obsidian"
        ".config/spotify"
        ".local/share/direnv/allow"
        ".minecraft"
        ".mozilla/firefox/main"
        ".railway"
        ".rustup"
        ".steam"
        ".vscode"
      ];
      files = [
        ".local/share/nix/trusted-settings.json"
      ];
      allowOther = true;
    };

    "/persist/bigdata/home/getpsyched" = {
      directories = [
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
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
