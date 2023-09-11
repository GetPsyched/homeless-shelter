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
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        b4dm4n.vscode-nixpkgs-fmt
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
        "[nix]"."editor.defaultFormatter" = "b4dm4n.nixpkgs-fmt";
      };
    };
  };
}
