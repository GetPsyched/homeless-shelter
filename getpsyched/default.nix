{ ... }:
{
  imports = [
    ./browser
    ./dev
    ./gui

    ./games.nix
  ];

  home = {
    username = "getpsyched";
    homeDirectory = "/home/getpsyched";
    stateVersion = "22.11";
  };

  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (_: true);

  programs.home-manager.enable = true;

  systemd.user.services.flameshot.Unit.After = [
    "graphical-session-pre.target"
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
