{ pkgs, ... }:
{
  nixpkgs.config.allowUnfreePackages = [
    "citrix-endpoint-analysis"
    "nsepa.deb"
    "citrix-secure-access"
    "nsginstaller64.deb"
    "citrix-workspace"
    "linuxx64"
  ];
  persist.state.homeDirectories = [
    ".local/share/selfservice"
  ];
  users.users.primary.packages = with pkgs; [
    citrix-endpoint-analysis
    citrix-workspace
  ];

  hjem.users.primary.files.".ICAClient/.eula_accepted".text = "";
}
