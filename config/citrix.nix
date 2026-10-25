{pkgs, ...}: {
  nixpkgs.config.allowUnfreePackages = [
    "citrix-workspace"
    "linuxx64"
  ];
  persist.state.homeDirectories = [
    ".ICAClient"
    ".local/share/.selfservice-wrapped"
  ];
  users.users.primary.packages = with pkgs; [
    citrix-workspace
  ];
}
