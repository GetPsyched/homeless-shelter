{ lib, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages.language = [
      {
        name = "git-commit";
        rulers = [ 80 ];
      }
      {
        name = "markdown";
        soft-wrap.enable = true;
        soft-wrap.wrap-indicator = "";
        soft-wrap.wrap-at-text-width = true;
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        language-servers = [ "nixd" ];
      }
      {
        name = "typescript";
        auto-format = true;
        formatter.command = "prettier --parser typescript";
      }
    ];

    languages.language-server = {
      nixd.command = lib.getExe pkgs.nixd;
      typescript-language-server.command = lib.getExe pkgs.nodePackages.typescript-language-server;
    };

    settings = {
      theme = "tokyonight";
      editor = {
        # diagnostics
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "error";

        bufferline = "multiple";
        color-modes = true;
        completion-replace = true;
        completion-timeout = 5;
        completion-trigger-len = 1;
        cursorline = true;
        cursor-shape.insert = "bar";
        file-picker.hidden = false;
        lsp.display-inlay-hints = true;
        preview-completion-insert = false;
        statusline.left = [
          "mode"
          "spinner"
          "version-control"
          "file-name"
          "read-only-indicator"
          "file-modification-indicator"
        ];
        true-color = true;
      };

      keys.normal.y = [
        "yank"
        ":clipboard-yank"
      ];
    };
  };
}
