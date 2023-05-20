{ pkgs, ... }: {
  home.packages = with pkgs; [
    gcc
    nodejs
    postman
    rustup
    sqlitebrowser
  ];
}
