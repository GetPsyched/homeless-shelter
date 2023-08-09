{ pkgs, ... }:
{
  imports = [
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./tealdeer.nix
    ./terminal.nix
  ];

  home.packages = with pkgs; [
    gcc
    nodejs
    postgresql
    postman
    python3
    railway
    rustup
    sqlitebrowser
  ];
}
