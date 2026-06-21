{ pkgs, ... }:
{
  nixpkgs.config.allowUnfreePackages = [
    "citrix-workspace"
    "linuxx64"
    "webex"
  ];
  persist.state.homeDirectories = [
    ".local/share/selfservice"
    ".local/share/Webex"
  ];
  users.users.primary.packages = with pkgs; [
    citrix-workspace
    webex
  ];

  hjem.users.primary.files.".ICAClient/.eula_accepted".text = "";
}
