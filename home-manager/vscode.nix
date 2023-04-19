{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
  };
}
