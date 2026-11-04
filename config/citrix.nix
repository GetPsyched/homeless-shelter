{pkgs, ...}: {
  nixpkgs.config.allowUnfreePackages = [
    "citrix-endpoint-analysis"
    "citrix-workspace"
    "linuxx64"
  ];
  persist.state.homeDirectories = [
    ".ICAClient"
    ".local/share/.selfservice-wrapped"
  ];
  users.users.primary.packages = with pkgs; [
    citrix-endpoint-analysis
    citrix-workspace
  ];
}
