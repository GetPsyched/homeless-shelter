{ pkgs, config, inputs, ... }: {
  home.packages = [
    pkgs.gamemode

    # Can also use pkgs.osu-lazer but, as of this commit, it does not support multiplayer
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
  ];
}
