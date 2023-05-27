{ pkgs, ... }:
{
  imports = [
    ./browser
    ./dev
    ./gui

    ./games.nix
  ];
}
