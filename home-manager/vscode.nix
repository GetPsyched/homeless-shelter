{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      esbenp.prettier-vscode
      github.copilot
      matklad.rust-analyzer
      ms-pyright.pyright
    ];
  };
}
