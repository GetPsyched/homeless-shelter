{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "tokyonight";

      editor.completion-timeout = 5;
      editor.preview-completion-insert = false;
      editor.completion-replace = true;
      editor.rulers = [ 80 ];
      editor.lsp.display-inlay-hints = true;
      editor.cursor-shape.insert = "bar";
      editor.file-picker.hidden = false;
    };
  };
}
