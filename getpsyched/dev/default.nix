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
    rustup
    sqlitebrowser
  ];
}
