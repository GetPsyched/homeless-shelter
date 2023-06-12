{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./shell.nix
    ./tealdeer.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    gcc
    nodejs
    postman
    python3
    railway
    rustup
    sqlitebrowser
  ];
}
