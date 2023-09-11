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
    postgresql
    postman
    sqlitebrowser
  ];
}
