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
        matklad.rust-analyzer
        ms-pyright.pyright
        ms-python.python
      ];

      userSettings = {
        "diffEditor.renderSideBySide" = false;
        "editor.inlineSuggest.enabled" = true;
        "window.menuBarVisibility" = "toggle";

        "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
        "[nix]"."editor.tabSize" = 2;
      };
    };
  };
}
