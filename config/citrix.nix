{ pkgs, ... }:
{
  nixpkgs.config.allowUnfreePackages = [
    "citrix-workspace"
    "linuxx64"
  ];
  persist.state.homeDirectories = [
    ".local/share/selfservice"
  ];
  users.users.primary.packages = with pkgs; [
    citrix-workspace
  ];

  hjem.users.primary.files.".ICAClient/.eula_accepted".text = "";
}
