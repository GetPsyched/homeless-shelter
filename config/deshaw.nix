{ pkgs, ... }:
{
  allowUnfreePackages = [
    "citrix-workspace"
    "webex"
  ];
  persist.state.homeDirectories = [ ".local/share/Webex" ];
  users.users.primary.packages = with pkgs; [
    citrix_workspace
    webex
  ];
}
