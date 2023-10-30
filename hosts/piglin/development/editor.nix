{ pkgs, ... }:
{
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
      package = pkgs.vscodium;

      userSettings = {
        "breadcrumbs.enabled" = false;
        "diffEditor.renderSideBySide" = false;
        "editor.formatOnSave" = true;
        "editor.inlineSuggest.enabled" = true;
        "explorer.confirmDragAndDrop" = false;
        "search.useGlobalIgnoreFiles" = true;
        "security.workspace.trust.enabled" = false;
        "terminal.integrated.enableMultiLinePasteWarning" = false;
        "terminal.integrated.enablePersistentSessions" = false;
        "window.menuBarVisibility" = "toggle";
        "workbench.startupEditor" = "none";

        "[css]"."editor.defaultFormatter" = "vscode.css-language-features";
        "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[nix]"."editor.tabSize" = 2;
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
        "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
        "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
        "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

        "javascript.updateImportsOnFileMove.enabled" = "always";
        "prettier.singleQuote" = true;
        "svelte.enable-ts-plugin" = true;
        "typescript.updateImportsOnFileMove.enabled" = "always";
      };
    };
  };
}
