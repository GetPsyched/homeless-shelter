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
        formatter.command = "nixfmt";
      }
      {
        name = "typescript";
        auto-format = true;
        formatter.command = "prettier --parser typescript";
      }
    ];

    settings = {
      theme = "tokyonight";

      editor.completion-timeout = 5;
      editor.preview-completion-insert = false;
      editor.completion-replace = true;
      editor.lsp.display-inlay-hints = true;
      editor.cursor-shape.insert = "bar";
      editor.file-picker.hidden = false;

      keys.normal.y = [
        "yank"
        ":clipboard-yank"
      ];
    };
  };
}
