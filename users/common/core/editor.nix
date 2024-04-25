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
        diffEditor = {
          ignoreTrimWhitespace = false;
          renderSideBySide = false;
        };
        editor = {
          codeActionsOnSave."source.organizeImports" = "always";
          cursorBlinking = "expand";
          cursorSmoothCaretAnimation = "on";
          formatOnSave = true;
          gotoLocation = {
            multipleDeclarations = "goto";
            multipleDefinitions = "goto";
            multipleImplementations = "goto";
            multipleReferences = "goto";
            multipleTypeDefinitions = "goto";
          };
          inlineSuggest.enabled = true;
        };
        explorer.confirmDragAndDrop = false;
        extensions = {
          autoUpdate = false;
          autoCheckUpdates = false;
          closeExtensionDetailsOnViewChange = true;
        };
        files.trimTrailingWhitespace = true;
        git = {
          openRepositoryInParentFolders = "always";
          inputValidation = true;
          inputValidationLength = 80;
          mergeEditor = true;
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

        "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
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

        javascript = {
          preferGoToSourceDefinition = true;
          updateImportsOnFileMove.enabled = "always";
        };
        prettier.singleQuote = true;
        svelte.enable-ts-plugin = true;
        typescript = {
          preferGoToSourceDefinition = true;
          updateImportsOnFileMove.enabled = "always";
        };
      };
    };
  };
}
