{
  programs.thunderbird = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "\${home}";
      DisableBuiltinPDFViewer = true;
      ManualAppUpdateOnly = true;
      OfferToSaveLoginsDefault = false;
      PromptForDownloadLocation = false;
    };
  };
  persist.state.homeDirectories = [ ".thunderbird/main" ];
}
