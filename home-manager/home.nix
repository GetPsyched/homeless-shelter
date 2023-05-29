{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    ../getpsyched
    # ./games.nix
  ];

  home = {
    username = "getpsyched";
    homeDirectory = "/home/getpsyched";
  };

  programs.feh.enable = true;
  programs.home-manager.enable = true;

  systemd.user.services.flameshot.Unit.After = [
    "graphical-session-pre.target"
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
