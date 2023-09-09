{ pkgs, config, inputs, ... }: {
  home.packages = with pkgs; [
    gamemode
    osu-lazer-bin

    (callPackage ../packages/atlauncher.nix { })
  ];
}
