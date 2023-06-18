{ ... }:
{
  imports = [
    ./browser
    ./dev
    ./gui

    ./games.nix
    ./thunderbird.nix
    ./wine.nix
  ];

  home = {
    username = "getpsyched";
    homeDirectory = "/home/getpsyched";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
