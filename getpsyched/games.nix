{ pkgs, config, inputs, ... }: {
  home.packages = [
    pkgs.gamemode
    (pkgs.callPackage ../packages/atlauncher.nix { })

    # Can also use pkgs.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    (inputs.nix-gaming.packages.${pkgs.system}.rocket-league.override { wine = inputs.nix-gaming.packages.${pkgs.system}.wine-ge; })
  ];
}
