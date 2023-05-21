{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    ./dev.nix
    ./firefox.nix
    ./flameshot.nix
    # ./games.nix
    ./git.nix
    ./konsole.nix
    ./sway
    ./tealdeer.nix
    # ./theme.nix
    ./vscode.nix
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "getpsyched";
    homeDirectory = "/home/getpsyched";
  };

  programs.feh.enable = true;
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    dtrx
    peek
  ];

  systemd.user.services.flameshot.Unit.After = [
    "graphical-session-pre.target"
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
