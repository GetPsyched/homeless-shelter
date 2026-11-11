{pkgs, ...}: {
  nixpkgs.config.allowUnfreePackages = [
    "citrix-endpoint-analysis"
    "citrix-workspace"
    "linuxx64"
    "webex"
  ];
  persist.state.homeDirectories = [
    ".ICAClient"
    ".local/share/.selfservice-wrapped"
    ".local/share/Webex"
  ];
  users.users.primary.packages = with pkgs; [
    citrix-endpoint-analysis
    citrix-workspace
    webex
  ];
}
