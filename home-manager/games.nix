{pkgs, config, inputs, ...}: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
  ];
}
