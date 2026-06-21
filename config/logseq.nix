{ pkgs, ... }:
{
  users.users.primary.packages = [ pkgs.logseq ];

  persist.data.homeDirectories = [ "logseq" ];
  persist.state.homeDirectories = [
    ".config/Logseq"
    ".logseq"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
}
