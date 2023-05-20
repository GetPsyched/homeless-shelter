{ pkgs, config, inputs, ... }: {
  home.packages = [
    pkgs.gamemode
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
  ];
}
