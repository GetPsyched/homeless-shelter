{ pkgs, ... }: {
  programs = {
    helix = {
      enable = true;

      settings = {
        theme = "tokyonight";
      };
    };

    vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        bungcip.better-toml
        esbenp.prettier-vscode
        github.copilot
        matklad.rust-analyzer
        ms-pyright.pyright
        ms-python.python
      ];
    };
  };
}
