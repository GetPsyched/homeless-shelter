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
      package = pkgs.vscodium;

      enableUpdateCheck = false;
      mutableExtensionsDir = false;

      userSettings = {
        accessibility.dimUnfocused.enabled = true;
        breadcrumbs.enabled = false;
        diffEditor.renderSideBySide = false;
        editor = {
          cursorBlinking = "expand";
          cursorSmoothCaretAnimation = "on";
          formatOnSave = true;
          inlineSuggest.enabled = true;
        };
        explorer.confirmDragAndDrop = false;
        extensions = {
          autoCheckUpdates = false;
          closeExtensionDetailsOnViewChange = true;
        };
        search = {
          smartCase = true;
          useGlobalIgnoreFiles = true;
        };
        security.workspace.trust.enabled = false;
        terminal.integrated = {
          cursorBlinking = true;
          cursorStyle = "line";
          enableMultiLinePasteWarning = false;
          enablePersistentSessions = false;
          showExitAlert = false;
        };
        window = {
          autoDetectColorScheme = true;
          closeWhenEmpty = true;
          menuBarVisibility = "toggle";
        };
        workbench = {
          panel.opensMaximized = "always";
          startupEditor = "none";
        };

        "[css]".editor.defaultFormatter = "vscode.css-language-features";
        "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[javascript]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[jsonc]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[nix]".editor = {
          tabSize = 2;
          defaultFormatter = "jnoortheen.nix-ide";
        };
        "[python]".editor.defaultFormatter = "ms-python.black-formatter";
        "[svelte]".editor.defaultFormatter = "svelte.svelte-vscode";
        "[typescript]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[typescriptreact]".editor.defaultFormatter = "esbenp.prettier-vscode";

        javascript.updateImportsOnFileMove.enabled = "always";
        prettier.singleQuote = true;
        svelte.enable-ts-plugin = true;
        typescript.updateImportsOnFileMove.enabled = "always";
      };
    };
  };
}
